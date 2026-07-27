#!/usr/bin/env python3

import re
import sys


def usage():
    print(
        "Usage: python3 get_device_tree_info.py "
        "<device_name> <device_tree_path> [synch_fifo]"
    )


if len(sys.argv) < 3:
    usage()
    sys.exit(1)


DEVICE_NAME = sys.argv[1]
DEVICE_TREE = sys.argv[2]

if len(sys.argv) > 3:
    isSynchFifo = True
    SYNCH_FIFO = sys.argv[3]
else:
    isSynchFifo = False
    SYNCH_FIFO = ""


try:
    with open(DEVICE_TREE, "r", encoding="utf-8") as device_tree_file:
        t = device_tree_file.read()
except OSError as error:
    print(
        f"Error: cannot open device tree file '{DEVICE_TREE}': {error}",
        file=sys.stderr,
    )
    sys.exit(1)


# -------------------------------------------------------------------------
# Detect DMA nodes
# -------------------------------------------------------------------------

isDma = len(re.findall(r"dma@", t)) > 0

if isDma:
    print("IS DMA!")


# -------------------------------------------------------------------------
# Device-tree parsing
# -------------------------------------------------------------------------

label_pattern = r"([a-zA-Z_][a-zA-Z0-9_-]*)"
address_pattern = r"[0-9a-fA-F]+"


# AXI configuration registers.
regexp = re.compile(
    rf"^\s*{label_pattern}\s*:\s*"
    rf"axi_cfg_register@{address_pattern}\s*\{{",
    re.MULTILINE,
)

configuration_registers = regexp.findall(t)


# AXI status registers.
regexp = re.compile(
    rf"^\s*{label_pattern}\s*:\s*"
    rf"axi_sts_register@{address_pattern}\s*\{{",
    re.MULTILINE,
)

status_registers = regexp.findall(t)


# Preserve the order used by the original generator:
# configuration registers first, then status registers.
registers = configuration_registers + status_registers


# AXI FIFO MM-S peripherals.
regexpr = re.compile(
    rf"^\s*{label_pattern}\s*:\s*"
    rf"axi_fifo_mm_s@{address_pattern}\s*\{{",
    re.MULTILINE,
)

fifos = regexpr.findall(t)


# Find the devices managed by this driver.
# AXI BRAM controllers and unsupported AXI peripherals are excluded.
regexpr = re.compile(
    rf"^\s*{label_pattern}\s*:\s*"
    rf"(axi_cfg_register|axi_sts_register|axi_fifo_mm_s)"
    rf"@{address_pattern}\s*\{{",
    re.MULTILINE,
)

fifosRegs = []
isRegs = []

for match in regexpr.finditer(t):
    device_label = match.group(1)
    device_type = match.group(2)

    fifosRegs.append(device_label)

    isRegs.append(
        device_type == "axi_cfg_register"
        or device_type == "axi_sts_register"
    )


print("Registers:", registers)
print("FIFOs:", fifos)
print("Supported devices:", fifosRegs)


if not fifosRegs:
    print(
        "Error: no supported AXI devices were found in the device tree.",
        file=sys.stderr,
    )
    print(
        "Expected node types: axi_cfg_register, "
        "axi_sts_register or axi_fifo_mm_s.",
        file=sys.stderr,
    )
    print(f"Device tree: {DEVICE_TREE}", file=sys.stderr)
    sys.exit(1)


if isSynchFifo and SYNCH_FIFO not in fifos:
    print(
        f"Error: the FIFO '{SYNCH_FIFO}' was not found "
        "in the device tree.",
        file=sys.stderr,
    )

    if fifos:
        print(
            "Available FIFO labels: " + ", ".join(fifos),
            file=sys.stderr,
        )
    else:
        print(
            "No AXI FIFO MM-S device was found.",
            file=sys.stderr,
        )

    sys.exit(1)


def get_iomap_name(device_label):
    """
    Return the C structure member suffix for a device-tree label.

    The FIFO selected through the third command-line argument is always
    exposed in the generated C code as:

        iomap_stream_fifo

    All other devices keep their device-tree label.
    """

    if isSynchFifo and device_label == SYNCH_FIFO:
        return "stream_fifo"

    return device_label


# -------------------------------------------------------------------------
# Generate IOCTL definitions
# -------------------------------------------------------------------------

regConf = ""
baseId = 20


for reg in registers:
    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_GET_"
        + reg.upper()
        + "\t\t"
        + "_IO("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ")\n"
    )

    baseId += 1

    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_SET_"
        + reg.upper()
        + "\t\t"
        + "_IO("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ")\n"
    )

    baseId += 1


for fifo in fifos:
    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_GET_"
        + fifo.upper()
        + "_LEN\t\t"
        + "_IO("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ")\n"
    )

    baseId += 1

    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_GET_"
        + fifo.upper()
        + "_VAL\t\t"
        + "_IO("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ")\n"
    )

    baseId += 1

    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_SET_"
        + fifo.upper()
        + "_VAL\t\t"
        + "_IO("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ")\n"
    )

    baseId += 1

    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_CLEAR_"
        + fifo.upper()
        + "\t\t"
        + "_IO("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ")\n"
    )

    baseId += 1


# -------------------------------------------------------------------------
# Generate register structure
# -------------------------------------------------------------------------

regStruct = ""

for reg in registers:
    regStruct += "\tchar " + reg + "_enable;\n"
    regStruct += "\tunsigned int " + reg + ";\n"


# -------------------------------------------------------------------------
# Generate header file
# -------------------------------------------------------------------------

try:
    with open(
        "zynq_device.h.template",
        "r",
        encoding="utf-8",
    ) as template_file:
        include = template_file.read()
except OSError as error:
    print(
        f"Error: cannot open zynq_device.h.template: {error}",
        file=sys.stderr,
    )
    sys.exit(1)


include = include.replace(
    "$$DEFINE_REGISTER_CODES$$",
    regConf,
)

include = include.replace(
    "$$DEFINE_REGISTER_STRUCT$$",
    regStruct,
)

include = include.replace(
    "$$DEVICE_NAME_U$$",
    DEVICE_NAME.upper(),
)

include = include.replace(
    "$$DEVICE_NAME_L$$",
    DEVICE_NAME.lower(),
)


header_output = DEVICE_NAME.lower() + ".h"

try:
    with open(
        header_output,
        "w",
        encoding="utf-8",
    ) as output_file:
        output_file.write(include)
except OSError as error:
    print(
        f"Error: cannot write '{header_output}': {error}",
        file=sys.stderr,
    )
    sys.exit(1)


# -------------------------------------------------------------------------
# Read C source template
# -------------------------------------------------------------------------

try:
    with open(
        "zynq_device.c.template",
        "r",
        encoding="utf-8",
    ) as template_file:
        source = template_file.read()
except OSError as error:
    print(
        f"Error: cannot open zynq_device.c.template: {error}",
        file=sys.stderr,
    )
    sys.exit(1)


# -------------------------------------------------------------------------
# Declare register and FIFO mapping pointers
# -------------------------------------------------------------------------

declReg = ""

for reg in registers:
    declReg += "\tvoid * iomap_" + reg + ";\n"


for fifo in fifos:
    iomap_name = get_iomap_name(fifo)
    declReg += "\tvoid * iomap_" + iomap_name + ";\n"


source = source.replace(
    "$$DECLARE_REGISTERS_IN_STRUCT$$",
    declReg,
)


# -------------------------------------------------------------------------
# Generate IOCTL implementation
# -------------------------------------------------------------------------

iomapReg = ""


for reg in registers:
    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_GET_"
        + reg.upper()
        + ":\n"
    )

    iomapReg += "\t{\n"

    iomapReg += (
        "\t\tif (copy_to_user("
        "(void __user *)arg, "
        "dev->iomap_"
        + reg
        + ", sizeof(u32)))\n"
    )

    iomapReg += "\t\t\treturn -EFAULT;\n"
    iomapReg += "\t\treturn 0;\n"
    iomapReg += "\t}\n"


    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_SET_"
        + reg.upper()
        + ":\n"
    )

    iomapReg += "\t{\n"

    iomapReg += (
        "\t\tif (copy_from_user("
        "dev->iomap_"
        + reg
        + ", "
        "(void __user *)arg, "
        "sizeof(u32)))\n"
    )

    iomapReg += "\t\t\treturn -EFAULT;\n"
    iomapReg += "\t\treturn 0;\n"
    iomapReg += "\t}\n"


for fifo in fifos:
    iomap_name = get_iomap_name(fifo)

    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_GET_"
        + fifo.upper()
        + "_LEN:\n"
    )

    iomapReg += "\t{\n"

    iomapReg += (
        "\t\tu32 val = readFifo("
        "dev->iomap_"
        + iomap_name
        + ", RDFO);\n"
    )

    iomapReg += (
        "\t\tif (copy_to_user("
        "(void __user *)arg, "
        "&val, sizeof(u32)))\n"
    )

    iomapReg += "\t\t\treturn -EFAULT;\n"
    iomapReg += "\t\treturn 0;\n"
    iomapReg += "\t}\n"


    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_GET_"
        + fifo.upper()
        + "_VAL:\n"
    )

    iomapReg += "\t{\n"

    iomapReg += (
        "\t\tu32 val = readFifo("
        "dev->iomap_"
        + iomap_name
        + ", RDFD);\n"
    )

    iomapReg += (
        "\t\tif (copy_to_user("
        "(void __user *)arg, "
        "&val, sizeof(u32)))\n"
    )

    iomapReg += "\t\t\treturn -EFAULT;\n"
    iomapReg += "\t\treturn 0;\n"
    iomapReg += "\t}\n"


    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_SET_"
        + fifo.upper()
        + "_VAL:\n"
    )

    iomapReg += "\t{\n"
    iomapReg += "\t\tu32 val;\n"

    iomapReg += (
        "\t\tif (copy_from_user("
        "&val, "
        "(void __user *)arg, "
        "sizeof(u32)))\n"
    )

    iomapReg += "\t\t\treturn -EFAULT;\n"

    iomapReg += (
        "\t\twriteFifo("
        "dev->iomap_"
        + iomap_name
        + ", TLR, 1);\n"
    )

    iomapReg += "\t\treturn 0;\n"
    iomapReg += "\t}\n"


    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_CLEAR_"
        + fifo.upper()
        + ":\n"
    )

    iomapReg += "\t{\n"

    iomapReg += (
        "\t\tclearFifo("
        "dev->iomap_"
        + iomap_name
        + ");\n"
    )

    iomapReg += "\t\treturn 0;\n"
    iomapReg += "\t}\n"


# GET_REGISTERS
iomapReg += (
    "\tcase "
    + DEVICE_NAME.upper()
    + "_GET_REGISTERS:\n"
)

iomapReg += "\t{\n"

iomapReg += (
    "\t\tstruct "
    + DEVICE_NAME.lower()
    + "_registers currConf;\n"
)

iomapReg += "\t\tmemset(&currConf, 0, sizeof(currConf));\n"

for reg in registers:
    iomapReg += (
        "\t\tcurrConf."
        + reg
        + " = *((u32 *)dev->iomap_"
        + reg
        + ");\n"
    )

iomapReg += (
    "\t\tif (copy_to_user("
    "(void __user *)arg, "
    "&currConf, "
    "sizeof(currConf)))\n"
)

iomapReg += "\t\t\treturn -EFAULT;\n"
iomapReg += "\t\treturn 0;\n"
iomapReg += "\t}\n"


# SET_REGISTERS
iomapReg += (
    "\tcase "
    + DEVICE_NAME.upper()
    + "_SET_REGISTERS:\n"
)

iomapReg += "\t{\n"

iomapReg += (
    "\t\tstruct "
    + DEVICE_NAME.lower()
    + "_registers currConf;\n"
)

iomapReg += (
    "\t\tif (copy_from_user("
    "&currConf, "
    "(void __user *)arg, "
    "sizeof(currConf)))\n"
)

iomapReg += "\t\t\treturn -EFAULT;\n"

for reg in registers:
    iomapReg += (
        "\t\tif (currConf."
        + reg
        + "_enable)\n"
    )

    iomapReg += (
        "\t\t\t*((u32 *)dev->iomap_"
        + reg
        + ") = currConf."
        + reg
        + ";\n"
    )

iomapReg += "\t\treturn 0;\n"
iomapReg += "\t}\n"


source = source.replace(
    "$$MAP_IOCTL$$",
    iomapReg,
)


# -------------------------------------------------------------------------
# Map the first supported peripheral
# -------------------------------------------------------------------------

mapFirstReg = ""

first_iomap_name = get_iomap_name(fifosRegs[0])

mapFirstReg += (
    "\tr_mem = platform_get_resource("
    "pdev, IORESOURCE_MEM, 0);\n"
)

mapFirstReg += "\tif (!r_mem)\n"
mapFirstReg += "\t\treturn -ENODEV;\n"

mapFirstReg += "\toff = r_mem->start & ~PAGE_MASK;\n"

mapFirstReg += (
    "\tstaticPrivateInfo.iomap_"
    + first_iomap_name
    + " = devm_ioremap("
    "&pdev->dev, "
    "r_mem->start + off, "
    "resource_size(r_mem));\n"
)

mapFirstReg += (
    "\tif (!staticPrivateInfo.iomap_"
    + first_iomap_name
    + ")\n"
)

mapFirstReg += "\t\treturn -ENOMEM;\n"


# -------------------------------------------------------------------------
# Map the remaining supported peripherals
# -------------------------------------------------------------------------

mapReg = ""


if isDma:
    start_index = 0
else:
    start_index = 1


for i in range(start_index, len(fifosRegs)):
    iomap_name = get_iomap_name(fifosRegs[i])

    mapReg += "\tcase " + str(i) + ":\n"

    mapReg += (
        "\t\tr_mem = platform_get_resource("
        "pdev, IORESOURCE_MEM, 0);\n"
    )

    mapReg += "\t\tif (!r_mem)\n"
    mapReg += "\t\t\treturn -ENODEV;\n"

    mapReg += "\t\toff = r_mem->start & ~PAGE_MASK;\n"

    mapReg += (
        "\t\tstaticPrivateInfo.iomap_"
        + iomap_name
        + " = devm_ioremap("
        "&pdev->dev, "
        "r_mem->start + off, "
        "resource_size(r_mem));\n"
    )

    mapReg += (
        "\t\tif (!staticPrivateInfo.iomap_"
        + iomap_name
        + ")\n"
    )

    mapReg += "\t\t\treturn -ENOMEM;\n"
    mapReg += "\t\tbreak;\n"


# -------------------------------------------------------------------------
# Replace source placeholders
# -------------------------------------------------------------------------

if isDma:
    source = source.replace(
        "$$MAP_FIRST_REGISTER$$",
        "",
    )
else:
    source = source.replace(
        "$$MAP_FIRST_REGISTER$$",
        mapFirstReg,
    )


source = source.replace(
    "$$MAP_REGISTERS$$",
    mapReg,
)

source = source.replace(
    "$$DEVICE_NAME_U$$",
    DEVICE_NAME.upper(),
)

source = source.replace(
    "$$DEVICE_NAME_L$$",
    DEVICE_NAME.lower(),
)


if isDma:
    source = source.replace(
        "$$SET_DEVICE_DMA_MODE$$",
        "#define HAS_DMA",
    )
else:
    source = source.replace(
        "$$SET_DEVICE_DMA_MODE$$",
        "",
    )


if isSynchFifo:
    source = source.replace(
        "$$SET_DEVICE_FIFO_MODE$$",
        "#define HAS_FIFO_INTERRUPT",
    )

    source = source.replace(
        "$$SYNCH_FIFO$$",
        SYNCH_FIFO,
    )
else:
    source = source.replace(
        "$$SET_DEVICE_FIFO_MODE$$",
        "",
    )

    source = source.replace(
        "$$SYNCH_FIFO$$",
        "",
    )


# -------------------------------------------------------------------------
# Generate C source file
# -------------------------------------------------------------------------

source_output = DEVICE_NAME.lower() + ".c"

try:
    with open(
        source_output,
        "w",
        encoding="utf-8",
    ) as output_file:
        output_file.write(source)
except OSError as error:
    print(
        f"Error: cannot write '{source_output}': {error}",
        file=sys.stderr,
    )
    sys.exit(1)


print("")
print("Driver files generated successfully:")
print(f"  {source_output}")
print(f"  {header_output}")

if isSynchFifo:
    print("")
    print(f"Synchronous FIFO label : {SYNCH_FIFO}")
    print("Generated C member     : iomap_stream_fifo")
#!/usr/bin/env python3

# Author: Gabriele Manduchi
# Modified by: Bevilacqua Mattia (ChatGPT) - Added BRAM and GPIO 

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

node_regexp = re.compile(
    rf"^\s*(?P<label>{label_pattern})\s*:\s*"
    rf"(?P<node>[a-zA-Z_][a-zA-Z0-9,_-]*)"
    rf"@(?P<address>{address_pattern})\s*\{{"
    rf"(?P<body>.*?)^\s*\}};",
    re.MULTILINE | re.DOTALL,
)


def classify_node(node_name, body):
    """Return the peripheral class used by the generated driver."""

    compatibles = re.findall(
        r'compatible\s*=\s*([^;]+);',
        body,
    )
    compatible_text = " ".join(compatibles)

    if node_name == "axi_cfg_register":
        return "cfg"
    if node_name == "axi_sts_register":
        return "sts"
    if node_name == "axi_fifo_mm_s":
        return "fifo"

    if (
        node_name in ("axi_bram_ctrl", "bram", "memory-controller")
        or "xlnx,axi-bram-ctrl" in compatible_text
    ):
        return "bram"

    if (
        node_name in ("axi_gpio", "gpio")
        and (
            node_name == "axi_gpio"
            or "xlnx,xps-gpio" in compatible_text
            or "xlnx,axi-gpio" in compatible_text
        )
    ):
        return "gpio"

    return None


def get_compatibles(body):
    """Extract all compatible strings from a device-tree node."""

    property_match = re.search(
        r"compatible\s*=\s*([^;]+);",
        body,
    )

    if not property_match:
        return []

    return re.findall(r'"([^"]+)"', property_match.group(1))


devices = []

for match in node_regexp.finditer(t):
    device_type = classify_node(
        match.group("node"),
        match.group("body"),
    )

    if device_type:
        devices.append(
            {
                "label": match.group("label"),
                "type": device_type,
                "address": int(match.group("address"), 16),
                "compatibles": get_compatibles(match.group("body")),
            }
        )


# AXI configuration and status registers.
configuration_registers = [
    device["label"] for device in devices
    if device["type"] == "cfg"
]

status_registers = [
    device["label"] for device in devices
    if device["type"] == "sts"
]


# Preserve the order used by the original generator:
# configuration registers first, then status registers.
registers = configuration_registers + status_registers


# AXI FIFO MM-S, AXI BRAM Controller and Xilinx AXI GPIO peripherals.
fifos = [
    device["label"] for device in devices
    if device["type"] == "fifo"
]

brams = [
    device["label"] for device in devices
    if device["type"] == "bram"
]

gpios = [
    device["label"] for device in devices
    if device["type"] == "gpio"
]

fifosRegs = [device["label"] for device in devices]


print("Registers:", registers)
print("FIFOs:", fifos)
print("BRAMs:", brams)
print("GPIOs:", gpios)
print("Supported devices:", fifosRegs)


if not fifosRegs:
    print(
        "Error: no supported AXI devices were found in the device tree.",
        file=sys.stderr,
    )
    print(
        "Expected node types: axi_cfg_register, "
        "axi_sts_register, axi_fifo_mm_s, "
        "AXI BRAM Controller or Xilinx AXI GPIO.",
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


for peripheral in brams + gpios:
    peripheral_u = peripheral.upper().replace("-", "_")

    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_READ_"
        + peripheral_u
        + "\t\t"
        + "_IOWR("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ", struct "
        + DEVICE_NAME.lower()
        + "_mmio_access)\n"
    )
    baseId += 1

    regConf += (
        "#define "
        + DEVICE_NAME.upper()
        + "_WRITE_"
        + peripheral_u
        + "\t\t"
        + "_IOW("
        + DEVICE_NAME.upper()
        + "_IOCTL_BASE, "
        + str(baseId)
        + ", struct "
        + DEVICE_NAME.lower()
        + "_mmio_access)\n"
    )
    baseId += 1


for gpio in gpios:
    gpio_u = gpio.upper().replace("-", "_")
    regConf += "\n/* Standard Xilinx AXI GPIO register offsets. */\n"
    regConf += "#define " + gpio_u + "_DATA_OFFSET\t0x000\n"
    regConf += "#define " + gpio_u + "_TRI_OFFSET\t0x004\n"
    regConf += "#define " + gpio_u + "_DATA2_OFFSET\t0x008\n"
    regConf += "#define " + gpio_u + "_TRI2_OFFSET\t0x00c\n"
    regConf += "#define " + gpio_u + "_GIER_OFFSET\t0x11c\n"
    regConf += "#define " + gpio_u + "_IP_ISR_OFFSET\t0x120\n"
    regConf += "#define " + gpio_u + "_IP_IER_OFFSET\t0x128\n"


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
# Declare mapping pointers and resource sizes
# -------------------------------------------------------------------------

declReg = ""

for device in devices:
    iomap_name = get_iomap_name(device["label"])
    declReg += "\tvoid __iomem *iomap_" + iomap_name + ";\n"
    declReg += (
        "\tresource_size_t iomap_"
        + iomap_name
        + "_size;\n"
    )


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


for peripheral in brams + gpios:
    iomap_name = get_iomap_name(peripheral)
    peripheral_u = peripheral.upper().replace("-", "_")

    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_READ_"
        + peripheral_u
        + ":\n"
    )
    iomapReg += "\t{\n"
    iomapReg += (
        "\t\tstruct "
        + DEVICE_NAME.lower()
        + "_mmio_access access;\n"
    )
    iomapReg += (
        "\t\tif (copy_from_user(&access, "
        "(void __user *)arg, sizeof(access)))\n"
    )
    iomapReg += "\t\t\treturn -EFAULT;\n"
    iomapReg += (
        "\t\tif ((access.offset & 3) || "
        "dev->iomap_"
        + iomap_name
        + "_size < sizeof(u32) || "
        "access.offset > dev->iomap_"
        + iomap_name
        + "_size - sizeof(u32))\n"
    )
    iomapReg += "\t\t\treturn -EINVAL;\n"
    iomapReg += (
        "\t\taccess.value = ioread32("
        "dev->iomap_"
        + iomap_name
        + " + access.offset);\n"
    )
    iomapReg += (
        "\t\tif (copy_to_user((void __user *)arg, "
        "&access, sizeof(access)))\n"
    )
    iomapReg += "\t\t\treturn -EFAULT;\n"
    iomapReg += "\t\treturn 0;\n"
    iomapReg += "\t}\n"

    iomapReg += (
        "\tcase "
        + DEVICE_NAME.upper()
        + "_WRITE_"
        + peripheral_u
        + ":\n"
    )
    iomapReg += "\t{\n"
    iomapReg += (
        "\t\tstruct "
        + DEVICE_NAME.lower()
        + "_mmio_access access;\n"
    )
    iomapReg += (
        "\t\tif (copy_from_user(&access, "
        "(void __user *)arg, sizeof(access)))\n"
    )
    iomapReg += "\t\t\treturn -EFAULT;\n"
    iomapReg += (
        "\t\tif ((access.offset & 3) || "
        "dev->iomap_"
        + iomap_name
        + "_size < sizeof(u32) || "
        "access.offset > dev->iomap_"
        + iomap_name
        + "_size - sizeof(u32))\n"
    )
    iomapReg += "\t\t\treturn -EINVAL;\n"
    iomapReg += (
        "\t\tiowrite32(access.value, "
        "dev->iomap_"
        + iomap_name
        + " + access.offset);\n"
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
# Map supported peripherals by physical resource address
# -------------------------------------------------------------------------

mapReg = ""

mapReg += (
    "\t\tr_mem = platform_get_resource("
    "pdev, IORESOURCE_MEM, 0);\n"
)
mapReg += "\t\tif (!r_mem)\n"
mapReg += "\t\t\treturn -ENODEV;\n\n"

for index, device in enumerate(devices):
    iomap_name = get_iomap_name(device["label"])
    keyword = "if" if index == 0 else "else if"

    mapReg += (
        "\t\t"
        + keyword
        + " (r_mem->start == (resource_size_t)0x"
        + format(device["address"], "x")
        + ") {\n"
    )
    mapReg += (
        "\t\t\tstaticPrivateInfo.iomap_"
        + iomap_name
        + " = devm_ioremap_resource("
        "&pdev->dev, r_mem);\n"
    )
    mapReg += (
        "\t\t\tif (IS_ERR(staticPrivateInfo.iomap_"
        + iomap_name
        + "))\n"
    )
    mapReg += (
        "\t\t\t\treturn PTR_ERR(staticPrivateInfo.iomap_"
        + iomap_name
        + ");\n"
    )
    mapReg += (
        "\t\t\tstaticPrivateInfo.iomap_"
        + iomap_name
        + "_size = resource_size(r_mem);\n"
    )
    mapReg += "\t\t}\n"

mapReg += "\t\telse {\n"
mapReg += (
    "\t\t\tdev_warn(&pdev->dev, "
    "\"unsupported AXI resource at %pa\\n\", "
    "&r_mem->start);\n"
)
mapReg += "\t\t\treturn -ENODEV;\n"
mapReg += "\t\t}\n"


# -------------------------------------------------------------------------
# Replace source placeholders
# -------------------------------------------------------------------------

source = source.replace(
    "$$MAP_REGISTERS$$",
    mapReg,
)

compatible_values = []

for device in devices:
    for compatible in device["compatibles"]:
        if compatible not in compatible_values:
            compatible_values.append(compatible)

ofCompat = ""

for compatible in compatible_values:
    ofCompat += (
        '    { .compatible = "'
        + compatible
        + '" },\n'
    )

source = source.replace(
    "$$DEFINE_DEVICE_COMPATIBLES$$",
    ofCompat,
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
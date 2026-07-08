# KR260

A collection of projects, scripts, and documentation for learning how to program the **AMD/Xilinx Kria KR260 Robotics Starter Kit**, starting from the simplest FPGA logic and progressing up to a full Linux (PetaLinux) system with PS↔PL communication via FIFO and DMA.

This repository started as a learning/lab path (Consorzio RFX) and includes both the Vivado projects developed step by step and a LaTeX-written guide documenting the workflow.

## Authors

- Bevilacqua Mattia
- Gabriele Manduchi

## Repository structure

```
KR260/
├── code/     # Vivado projects (VHDL/Verilog), in increasing order of complexity
├── docs/     # PetaLinux/FPGA automation scripts and support files (XDC, IP)
└── txt/
    └── guide/    # LaTeX guide (.tex sources + compiled PDF) with images
```

### `code/`

Each subfolder is a standalone Vivado project (containing its own `.xpr`, sources, constraints, and — where present — synthesis/implementation artifacts). Projects are organized by increasing difficulty:

| Project | Description |
|---|---|
| `example` | Base/starter template project |
| `fan_ex` | Introductory example |
| `nand_bm`, `nand_ps_mk_III` | NAND logic gate, first in pure FPGA logic, then driven by the Processing System (PS) |
| `adder` | Simple VHDL adder |
| `prescaler` | Frequency divider / prescaler |
| `blink_mk_III` → `blink_mk_VIII` | Progressive evolution of the classic "blink LED": from programmable logic (PL) alone up to integration with an AXI-Stream ramp generator, an AXI configuration register, and behavioral simulation (xsim) |
| `PID` | PID controller implementation |

Hand-written `.vhd`/`.v` files are typically found under `<project>.srcs/sources_1/new/`, while pin constraints are in the `.xdc` files under `<project>.srcs/constrs_1/`.

### `docs/`

Scripts and support files shared across projects:

- **`prj-create.sh`** — automates creating/resuming a PetaLinux project: imports the hardware (XSA exported from Vivado), runs the build, and generates `BOOT.BIN` and a bootable `.wic` SD card image.
- **`programm-fpga.sh`** — meant to be run **on the board** (via SSH/serial): programs the FPGA at runtime through the Linux FPGA Manager, with optional support for device-tree overlays and kernel module loading.
- **`core_init_mk_I.tcl`, `core_init_mk_II.tcl`** — Vivado Tcl scripts for project initialization/configuration.
- **`axi_cfg_register.v`** — Verilog module implementing an AXI configuration register, reused across multiple projects.
- **`Kria_K26_SOM_Rev1.xdc`, `physical_constraint.xdc`** — physical/pin constraints for the K26 SOM and the KR260 carrier card.
- **`2022.2_PetaLinux_Package_List.xlsx`, `2024.2_PetaLinux_OS_Package_List.xlsx`** — PetaLinux package lists for the respective toolchain versions.

### `txt/guide/`

A complete LaTeX guide (**KRIA KR260 Robotics Starter Kit: the first steps**), with a precompiled PDF (`kria_guide.pdf`). It covers:

1. **Introduction** — requirements, Vivado and PetaLinux SDK installation, environment setup.
2. **Blink LED** — basic project using FPGA logic only.
3. **Blink LED with a custom OS** — same application, but with a dedicated PetaLinux configuration, laying the groundwork for later projects.
4. **FIFO** — implementing two FIFO memories for PS↔PL communication.
5. **DMA** — the same read/write operations implemented via Direct Memory Access.

## Required toolchain

| Tool | Version used in this project |
|---|---|
| Vivado | 2024.1 |
| PetaLinux SDK | 2022.2 |
| Host OS | Linux (the guide was validated on CentOS Stream 9; instructions for Ubuntu are also included) |

> Newer tool versions might not be compatible with the files and procedures described here: always check compatibility before installing Vivado and the PetaLinux SDK.

## Typical workflow

1. **Hardware development**: open the desired Vivado project under `code/`, synthesize/implement the design, and export the hardware (`.xsa`).
2. **Linux system build**: use `docs/prj-create.sh` to create (or resume) a PetaLinux project, import the exported XSA, configure the RootFS if needed, and complete the build (it generates `BOOT.BIN` and the `.wic` image).
3. **Boot the board**: flash the `.wic` image to an SD card and boot the KR260.
4. **Runtime FPGA programming**: from the board, run `docs/programm-fpga.sh` to load the bitstream (`.bin`), any device-tree overlay, and the required kernel modules.
5. **Deep dive**: refer to `txt/guide/kria_guide.pdf` for a detailed walkthrough of each project, from the simplest logic up to FIFO and DMA.

## Hardware requirements

- AMD/Xilinx **Kria KR260 Robotics Starter Kit** (K26 SOM + carrier card)
- microSD card for booting
- USB/serial cable or Ethernet connection for SSH access to the board

## License

Not specified in the repository.

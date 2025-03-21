FPGA-SoC-Linux-Kernel-6.6
====================================================================================

Overview
------------------------------------------------------------------------------------

### Introduction

This Repository provides a Linux Kernel (v6.6.x) Image and Device Trees for FPGA-SoC.

### Note

**The Linux Kernel Image provided in this repository is not official.**    
**I modified it to my liking. Please handle with care.**    

### Features

* Hardware
  + ZYBO    : AMD(Xilinx) Zynq-7000 ARM/FPGA SoC Trainer Board by Digilent
  + ZYBO-Z7 : AMD(Xilinx) Zynq-7020 Development Board by Digilent
  + PYNQ-Z1 : Python Productive for Zynq by Digilent
  + DE0-Nano-SoC : Intel(Altera) SoC FPGA Development Kit by Terasic
  + DE10-Nano    : Intel(Altera) SoC FPGA Development Kit by Terasic
* Linux Kernel Version 6.6.x
  + Available in both Xilinx-Zynq-7000 and Altera-SoC in a single image
  + Enable Device Tree Overlay
  + Enable FPGA Manager
  + Enable FPGA Bridge
  + Enable FPGA Reagion
  + Patch for issue #3(USB-HOST does not work with PYNQ-Z1)

Release
------------------------------------------------------------------------------------

The main branch contains only Readme.md.     
For Linux Kernel image and Debian Packages, please refer to the respective release tag listed below.

| Version  | Local Name          | Build Version | Release Tag          |
|:---------|:--------------------|:--------------|:---------------------|
| 6.6.40   | armv7-fpga          | 2             | [6.6.40-armv7-fpga-2](https://github.com/ikwzm/FPGA-SoC-Linux-Kernel-6.6/tree/6.6.40-armv7-fpga-2) |

Download
------------------------------------------------------------------------------------

```console
shell$ export RELEASE_TAG=6.6.40-armv7-fpga-2
shell$ wget https://github.com/ikwzm/FPGA-SoC-Linux-Kernel-6.6/archive/refs/tags/$RELEASE_TAG.tar.gz
shell$ tar xfz $RELEASE_TAG.tar.gz
shell$ cd FPGA-SoC-Linux-Kernel-6.6-$RELEASE_TAG
```

### Build Linux Kernel

There are two ways

1. run scripts/build-linux-6.6.40-armv7-fpga.sh (easy)
2. run this chapter step-by-step (annoying)

#### Download Linux Kernel Source

##### Clone from linux-stable.git

```console
shell$ git clone --depth 1 -b v6.6.40 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.40-armv7-fpga
```

##### Make Build Branch

```console
shell$ cd linux-6.6.40-armv7-fpga
shell$ git checkout -b linux-6.6.40-armv7-fpga refs/tags/v6.6.40
```

#### Patch to Linux Kernel

##### Patch for armv7-fpga

```console
shell$ patch -p1 < ../patches/linux-6.6.40-armv7-fpga.diff
shell$ cp ../files/armv7_fpga_defconfig arch/arm/configs
shell$ git add --update
shell$ git add arch/arm/configs/armv7_fpga_defconfig
shell$ git add arch/arm/boot/dts/xilinx/zynq-pynqz1.dts
shell$ git commit -m "patch for armv7-fpga"
```

##### Patch for usb chipidea driver

```console
shell$ patch -p1 < ../patches/linux-6.6.40-armv7-fpga-patch-usb-ulpi.diff
shell$ git add --update
shell$ git commit -m "patch for usb chipidea driver for issue #3"
```

##### Patch for build debian package script

```console
shell$ patch -p1 < ../patches/linux-6.6.40-armv7-fpga-builddeb.diff
shell$ git add --update
shell$ git commit -m "patch for scripts/package/builddeb to add tools/include and postinst script to header package"
```

##### Create tag and .version

```console
shell$ git tag -a v6.6.40-armv7-fpga -m "release v6.6.40-armv7-fpga-1"
shell$ echo 0 > .version
```

### Build

#### Setup for Build 

````console
shell$ cd linux-6.6.40-armv7-fpga
shell$ export ARCH=arm
shell$ export CROSS_COMPILE=arm-linux-gnueabihf-
shell$ make armv7_fpga_defconfig
````

#### Build Linux Kernel and device tree

````console
shell$ export DTC_FLAGS=--symbols
shell$ make deb-pkg
````

### Install

#### Install kernel image to this repository

```console
shell$ cp arch/arm/boot/zImage ../vmlinuz-6.6.40-armv7-fpga-1
shell$ install -d              ../files
shell$ cp .config              ../files/config-6.6.40-armv7-fpga-1
```

#### Install devicetree to this repository

```console
shell$ install -d                           ../devicetrees/6.6.40-armv7-fpga-1
shell$ cp arch/arm/boot/dts/xilinx/*        ../devicetrees/6.6.40-armv7-fpga-1
shell$ cp arch/arm/boot/dts/intel/socfpga/* ../devicetrees/6.6.40-armv7-fpga-1
```


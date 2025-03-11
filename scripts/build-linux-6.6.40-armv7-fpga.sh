#!/bin/bash

CURRENT_DIR=`pwd`
KERNEL_VERSION=6.6.40
KERNEL_EXTRA_VERSION=-armv7-fpga
KERNEL_LOCAL_VERSION=
KERNEL_STABLE_VERSION=v$KERNEL_VERSION
BUILD_VERSION=1
KERNEL_RELEASE=$KERNEL_VERSION$KERNEL_EXTRA_VERSION$KERNEL_LOCAL_VERSION
KERNEL_VERSION_TAG=v$KERNEL_VERSION$KERNEL_EXTRA_VERSION
LINUX_BUILD_DIR=linux-$KERNEL_RELEASE
KERNEL_DEFCONFIG=armv7_fpga_defconfig

echo "KERNEL_VERSION   =" $KERNEL_VERSION
echo "KERNEL_RELEASE   =" $KERNEL_RELEASE
echo "BUILD_VERSION    =" $BUILD_VERSION
echo "LINUX_BUILD_DIR  =" $LINUX_BUILD_DIR
echo "KERNEL_DEFCONFIG =" $KERNEL_DEFCONFIG

## Download Linux Kernel Source

### Clone from linux-stable.git

git clone --depth 1 -b $KERNEL_STABLE_VERSION git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git $LINUX_BUILD_DIR

### Make Build Branch

cd $LINUX_BUILD_DIR
git checkout -b $KERNEL_RELEASE refs/tags/$KERNEL_STABLE_VERSION

## Patch to Linux Kernel

### Patch for armv7-fpga
patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION.diff
cp ../files/$KERNEL_DEFCONFIG arch/arm/configs/
git add --all
git commit -m "[patch] for $KERNEL_VERSION$KERNEL_EXTRA_VERSION"

### Patch for usb chipidea driver
patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-usb-ulpi.diff
git add --all
git commit -m "[patch] for usb ulpi driver for issue #3"

### Patch for build debian package script
patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-builddeb.diff
git add --all
git commit -m "[update] scripts/package/builddeb to add tools/include and postinst script to header package."

### Create tag and .version
git tag -a $KERNEL_VERSION_TAG -m "release $KERNEL_VERSION_TAG-$BUILD_VERSION"
echo `expr $BUILD_VERSION - 1` > .version

## Build

### Setup for Build 
if [ -z $ARCH ]; then
    export ARCH=arm
fi
if [ -z $CROSS_COMPILE ]; then
    export CROSS_COMPILE=arm-linux-gnueabihf-
fi
make $KERNEL_DEFCONFIG

### Build Linux Kernel and device tree
export DTC_FLAGS=--symbols
rm -rf debian
make deb-pkg
 
## Install

### Install kernel image to this repository

cp arch/arm/boot/zImage ../vmlinuz-$KERNEL_RELEASE-$BUILD_VERSION
install -d              ../files
cp .config              ../files/config-$KERNEL_RELEASE-$BUILD_VERSION

### Install devicetree to this repository

install -d                                  ../devicetrees/$KERNEL_RELEASE-$BUILD_VERSION
cp arch/arm/boot/dts/xilinx/*               ../devicetrees/$KERNEL_RELEASE-$BUILD_VERSION
cp arch/arm/boot/dts/intel/socfpga/socfpga* ../devicetrees/$KERNEL_RELEASE-$BUILD_VERSION


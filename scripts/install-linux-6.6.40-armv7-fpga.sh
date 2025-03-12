#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
REPO_DIR=$(cd $(dirname $0); cd .. ; pwd)
KERNEL_VERSION=6.6.40
EXTRA_VERSION=-armv7-fpga
LOCAL_VERSION=
BUILD_VERSION=2

. "$SCRIPT_DIR/install-variables-armv7-fpga.sh"
. "$SCRIPT_DIR/install-command.sh"

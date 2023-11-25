#!/bin/bash

PS2TOOLCHAIN_DVP_REPO_URL="https://github.com/ps2dev/ps2toolchain-dvp.git"
PS2TOOLCHAIN_DVP_DEFAULT_REPO_REF="main"
PS2TOOLCHAIN_IOP_REPO_URL="https://github.com/ps2dev/ps2toolchain-iop.git"
PS2TOOLCHAIN_IOP_DEFAULT_REPO_REF="main"
PS2TOOLCHAIN_EE_REPO_URL="https://github.com/ps2dev/ps2toolchain-ee.git"
PS2TOOLCHAIN_EE_DEFAULT_REPO_REF="main"

if test -f "$PS2DEV_CONFIG_OVERRIDE"; then
  source "$PS2DEV_CONFIG_OVERRIDE"
fi

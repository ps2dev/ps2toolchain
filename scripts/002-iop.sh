#!/bin/bash
# 002-iop.sh by Francisco Javier Trujillo Mata (fjtrujy@gmail.com)

## Download the source code.
if test ! -d "ps2toolchain-iop/.git"; then
	git clone https://github.com/fjtrujy/ps2toolchain-iop && cd ps2toolchain-iop || exit 1
else
	cd ps2toolchain-iop &&
		git pull && git fetch origin &&
		git reset --hard origin/master || exit 1
fi

## Build and install
./toolchain.sh

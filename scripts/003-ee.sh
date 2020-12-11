#!/bin/bash
# 003-ee.sh by Francisco Javier Trujillo Mata (fjtrujy@gmail.com)

## Download the source code.
if test ! -d "ps2toolchain-ee/.git"; then
	git clone https://github.com/fjtrujy/ps2toolchain-ee && cd ps2toolchain-ee || exit 1
else
	cd ps2toolchain-ee &&
		git pull && git fetch origin &&
		git reset --hard origin/master || exit 1
fi

## Build and install
./toolchain.sh

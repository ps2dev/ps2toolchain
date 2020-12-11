#!/bin/bash
# 001-dvp.sh by Francisco Javier Trujillo Mata (fjtrujy@gmail.com)

## Download the source code.
if test ! -d "ps2toolchain-dvp/.git"; then
	git clone https://github.com/fjtrujy/ps2toolchain-dvp && cd ps2toolchain-dvp || exit 1
else
	cd ps2toolchain-dvp &&
		git pull && git fetch origin &&
		git reset --hard origin/master || exit 1
fi

## Build and install
./toolchain.sh

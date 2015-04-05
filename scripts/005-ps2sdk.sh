#!/bin/sh

## make sure ps2sdk's makefile does not use it
unset PS2SDKSRC

 cd ps2sdk

 ## Build and install
 make -j8 && make install -j8 || { exit 1; }

 ## Replace newlib's crt0 with the one in ps2sdk.
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$PS2DEV/ee/lib/gcc-lib/ee/3.2.3/crt0.o" || { exit 1; }
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$PS2DEV/ee/mips64r5900el-ps2-elf/lib/crt0.o" || { exit 1; }

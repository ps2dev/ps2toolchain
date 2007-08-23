#!/bin/sh
# ps2sdk.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 if test ! -d "ps2sdk"; then
  svn export svn://svn.ps2dev.org/ps2/trunk/ps2sdk || { exit 1; }
 else
  svn update ps2sdk || { exit 1; }
 fi

 ## Enter the source directory.
 cd ps2sdk || { exit 1; }

 ## Build and install.
 make clean && make -j 2 && make release && make clean || { exit 1; }

 ## Replace newlib's crt0 with the one in ps2sdk.
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$PS2DEV/ee/lib/gcc-lib/ee/3.2.2/crt0.o" || { exit 1; }
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$PS2DEV/ee/ee/lib/crt0.o" || { exit 1; }

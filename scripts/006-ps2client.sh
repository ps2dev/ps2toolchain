#!/bin/sh
# ps2client.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 if test ! -d "ps2client"; then
  svn checkout svn://svn.ps2dev.org/ps2/trunk/ps2client || { exit 1; }
 else
  svn update ps2client || { exit 1; }
 fi

 ## Enter the source directory.
 cd ps2client || { exit 1; }

 ## Build and install.
 make clean && make && make install && make clean || { exit 1; }

#!/bin/bash
# ps2client.sh by Dan Peori (danpeori@oopo.net)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

 ## Download the source code.
 if test ! -d "ps2client/.git"; then
  echo "Downloading ps2client source code."
  git clone https://github.com/ps2dev/ps2client && cd ps2client || exit 1
 else
  echo "Updating local ps2client source code."
  cd ps2client &&
  git pull && git fetch origin &&
  git reset --hard origin/master || exit 1
 fi

 ## Compile and install.
 echo "Building ps2client..."
 make clean && make -j $PROC_NR && make install && make clean || { exit 1; }

 ## Exit the build directory.
 cd .. || { exit 1; }

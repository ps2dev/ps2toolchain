#!/bin/sh
# ps2client.sh by Dan Peori (danpeori@oopo.net)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

 ## Download the source code.
 if test ! -d "ps2client/.git"; then
  git clone https://github.com/ps2dev/ps2client && cd ps2client || exit 1
 else
  cd ps2client &&
  git fetch origin &&
  git reset --hard origin/master || exit 1
 fi

 ## Build and install.
 make clean && make -j $(nproc) && make install && make clean || { exit 1; }

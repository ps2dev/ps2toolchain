#!/bin/sh
# ps2client.sh by Dan Peori (danpeori@oopo.net)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

export GIT_DIR="$DOWNLOAD_DIR/ps2client/.git"

 ## Download the source code.
 if test ! -d "$GIT_DIR"; then
  git clone -n git://github.com/ps2dev/ps2client.git "$DOWNLOAD_DIR/ps2client/" || \
    exit 1
 else
  git fetch origin
 fi

  rm -rf ps2client &&
  mkdir ps2client &&
  cd ps2client &&
  git reset --hard origin/master || exit 1

 ## Build and install.
 make clean && make && make install && make clean || { exit 1; }

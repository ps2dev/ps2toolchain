#!/bin/sh
# ps2sdk.sh by Dan Peori (danpeori@oopo.net)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

# make sure ps2sdk's makefile does not use it
unset PS2SDKSRC

export GIT_DIR="$DOWNLOAD_DIR/ps2sdk/.git"

 ## Download the source code.
 if test ! -d "$GIT_DIR"; then
  git clone -n git://github.com/ps2dev/ps2sdk.git "$DOWNLOAD_DIR/ps2sdk/" || \
    exit 1
 else
  git fetch origin
 fi

  rm -rf ps2sdk &&
  mkdir ps2sdk &&
  cd ps2sdk &&
  git reset --hard origin/master || exit 1

 ## Build and install.
 make clean && make -j 2 && \
PS2SDK="$_DESTDIR$PS2SDK" make release && \
make clean || { exit 1; }

 ## Replace newlib's crt0 with the one in ps2sdk.
mkdir -p "$_DESTDIR$PS2DEV/ee/lib/gcc-lib/ee/3.2.2/" "$_DESTDIR$PS2DEV/ee/ee/lib/"
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$_DESTDIR$PS2DEV/ee/lib/gcc-lib/ee/3.2.2/crt0.o" || { exit 1; }
 ln -sf "$PS2SDK/ee/startup/crt0.o" "$_DESTDIR$PS2DEV/ee/ee/lib/crt0.o" || { exit 1; }

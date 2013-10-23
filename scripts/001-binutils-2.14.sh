#!/bin/sh
# binutils-2.14.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 SOURCE=https://github.com/downloads/ps2dev/ps2toolchain/binutils-2.14.tar.bz2
 fname=`basename "$SOURCE"`
 [ -f "$DOWNLOAD_DIR/$fname" ] || \
   wget --continue --no-check-certificate -O "$DOWNLOAD_DIR/$fname" $SOURCE || \
     { exit 1; }

 ## Unpack the source code.
 rm -Rf binutils-2.14 && tar xfj "$DOWNLOAD_DIR/$fname" || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd binutils-2.14 && cat "$PS2TOOLCHAIN_ROOT/patches/"binutils-2.14-PS2.patch | patch -p1 || { exit 1; }

 ## For each target...
 for TARGET in "ee" "iop" "dvp"; do

  ## Create and enter the build directory.
  mkdir "build-$TARGET" && cd "build-$TARGET" || { exit 1; }

  ## Configure the build.
  CFLAGS="-O0" ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }

  ## Compile and install.
  make clean && make -j 2 && make install prefix="${_DESTDIR}$PS2DEV/$TARGET" && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done

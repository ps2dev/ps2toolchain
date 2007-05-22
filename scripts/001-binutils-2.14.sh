#!/bin/sh
# binutils-2.14.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 if test ! -f "binutils-2.14.tar.bz2"; then
  wget ftp://ftp.gnu.org/pub/gnu/binutils/binutils-2.14.tar.bz2 || { exit 1; }
 fi

 ## Unpack the source code.
 rm -Rf binutils-2.14 && tar xfvj binutils-2.14.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd binutils-2.14 && cat ../../patches/binutils-2.14-PS2.patch | patch -p1 || { exit 1; }

 ## For each target...
 for TARGET in "ee" "iop" "dvp"; do

  ## Create and enter the build directory.
  mkdir "build-$TARGET" && cd "build-$TARGET" || { exit 1; }

  ## Configure the build.
  ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }

  ## Compile and install.
  make clean && make -j 2 && make install && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done

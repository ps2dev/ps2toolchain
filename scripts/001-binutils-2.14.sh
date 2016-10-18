#!/bin/bash
# binutils-2.14.sh by Dan Peori (danpeori@oopo.net)

BINUTILS_VERSION=2.14
SOURCE=http://ftpmirror.gnu.org/binutils/binutils-$BINUTILS_VERSION.tar.bz2

 ## Download the source code.
 echo "Downloading binutils-$BINUTILS_VERSION source code."
 wget --continue $SOURCE || { exit 1; }

 ## Unpack the source code.
 echo "Decompressing binutils-$BINUTILS_VERSION."
 rm -Rf binutils-$BINUTILS_VERSION && tar xfj binutils-$BINUTILS_VERSION.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd binutils-$BINUTILS_VERSION || { exit 1; }
 if [ -e ../../patches/binutils-$BINUTILS_VERSION-PS2.patch ]; then
   cat ../../patches/binutils-$BINUTILS_VERSION-PS2.patch | patch -p1 || { exit 1; }
 fi
 cat ../../patches/binutils-$BINUTILS_VERSION-disable-makeinfo-when-texinfo-is-too-new.patch | patch -p0 || { exit 1; }

 ## For each target...
 for TARGET in "ee" "iop" "dvp"; do

  ## Create and enter the build directory.
  echo "Building binutils-$TARGET..."
  mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

  ## Configure the build.
  if [ ${OSVER:0:6} == Darwin ]; then
    CC=/usr/bin/gcc CXX=/usr/bin/g++ LD=/usr/bin/ld CFLAGS="-O0 -ansi -Wno-implicit-int -Wno-return-type" ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }
  else
    ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }
  fi

  ## Compile and install.
  make clean && make -j $PROC_NR CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=0" && make install && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done

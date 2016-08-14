#!/bin/bash
# binutils-2.14.sh by Dan Peori (danpeori@oopo.net)

 BINUTILS_VERSION=2.14
 ## Download the source code.
 SOURCE=http://ftpmirror.gnu.org/binutils/binutils-$BINUTILS_VERSION.tar.bz2
 wget --continue $SOURCE || { exit 1; }

 ## Unpack the source code.
 echo Decompressing Binutils $BINUTILS_VERSION. Please wait.
 rm -Rf binutils-$BINUTILS_VERSION && tar xfj binutils-$BINUTILS_VERSION.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd binutils-$BINUTILS_VERSION || { exit 1; }
 if [ -e ../../patches/binutils-$BINUTILS_VERSION-PS2.patch ]; then
 	cat ../../patches/binutils-$BINUTILS_VERSION-PS2.patch | patch -p1 || { exit 1; }
 fi
 cat ../../patches/binutils-$BINUTILS_VERSION-disable-makeinfo-when-texinfo-is-too-new.patch | patch -p0 || { exit 1; }

 ## Determine the maximum number of processes that Make can work with.
 ## MinGW's Make doesn't work properly with multi-core processors.
 OSVER=$(uname)
 if [ ${OSVER:0:10} == MINGW32_NT ]; then
 	PROC_NR=2
 else
 	PROC_NR=$(nproc)
 fi

 ## For each target...
 for TARGET in "ee" "iop" "dvp"; do

  ## Create and enter the build directory.
  mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

  ## Configure the build.
  if [ ${OSVER:0:6} == Darwin ]; then
    CC=/usr/bin/gcc CXX=/usr/bin/g++ LD=/usr/bin/ld CFLAGS="-O0 -ansi -Wno-implicit-int -Wno-return-type" ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }
  else
    ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }
  fi

  ## Compile and install.
  make clean && make -j $PROC_NR && make install && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done

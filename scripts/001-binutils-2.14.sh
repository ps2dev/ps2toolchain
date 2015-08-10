#!/bin/sh
# binutils-2.14.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 SOURCE=http://ftpmirror.gnu.org/binutils/binutils-2.14.tar.bz2
 wget --continue $SOURCE || { exit 1; }

 BIN_VERSION=2.24
 SOURCE2=http://ftpmirror.gnu.org/binutils/binutils-$BIN_VERSION.tar.bz2
 wget --continue $SOURCE2 || { exit 1; }

 ## Unpack the source code.
 echo Decompressing Binutils. Please wait.
 rm -Rf binutils-2.14 && tar xfj binutils-2.14.tar.bz2 || { exit 1; }
 rm -Rf binutils-$BIN_VERSION && tar xfj binutils-$BIN_VERSION.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd binutils-2.14 && cat ../../patches/binutils-2.14-PS2.patch | patch -p1 || { exit 1; }

 ## For each target that only supports old toolchain...
 for TARGET in "iop" "dvp"; do

  ## Create and enter the build directory.
  mkdir "build-$TARGET" && cd "build-$TARGET" || { exit 1; }

  ## Configure the build.
  CFLAGS="-O0" ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }

  ## Compile and install.
  make clean && make -j 2 && make install && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done

 cd ..

 ## Enter the source directory and patch the source code.
 cd binutils-$BIN_VERSION || { exit 1; }
 if [ -e ../patches/binutils-$BIN_VERSION-PS2.patch ]; then
 	cat ../../patches/binutils-$BIN_VERSION-PS2.patch | patch -p1 || { exit 1; }
 fi

 ## For each target that supports new toolchain...
 for TARGET in "ee"; do

  ## Create and enter the build directory.
  mkdir "build-$TARGET" && cd "build-$TARGET" || { exit 1; }

  ## Configure the build.
  ../configure --prefix="$PS2DEV/$TARGET" --target="mips64r5900el-ps2-elf" --program-prefix="$EE_TOOL_PREFIX" || { exit 1; }

  ## Compile and install.
  make clean && make -j 2 && make install && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done


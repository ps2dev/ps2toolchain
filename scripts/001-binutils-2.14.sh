#!/bin/sh
# binutils-2.14.sh by Dan Peori (danpeori@oopo.net)
# binutils-2.25.1.sh by AKuHAK

 ## Download the source code.
 OLD_BIN_VERSION=2.14
 SOURCE=http://ftpmirror.gnu.org/binutils/binutils-$OLD_BIN_VERSION.tar.bz2
 wget --continue $SOURCE || { exit 1; }

 ## Unpack the source code.
 echo Decompressing Binutils $OLD_BIN_VERSION. Please wait.
 rm -Rf binutils-$OLD_BIN_VERSION && tar xfj binutils-$OLD_BIN_VERSION.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd binutils-$OLD_BIN_VERSION && cat ../../patches/binutils-$OLD_BIN_VERSION-PS2.patch | patch -p1 || { exit 1; }

 ## Disables generating documentation (new texinfo does not like the old .texi files)
 echo "MAKEINFO = :" >> Makefile.in
  
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

 ## Download the source code.
 BIN_VERSION=2.25.1
 SOURCE2=http://ftpmirror.gnu.org/binutils/binutils-$BIN_VERSION.tar.bz2
 wget --continue $SOURCE2 || { exit 1; }

 ## Unpack the source code.
 echo Decompressing Binutils $BIN_VERSION. Please wait.
 rm -Rf binutils-$BIN_VERSION && tar xfj binutils-$BIN_VERSION.tar.bz2 || { exit 1; }

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


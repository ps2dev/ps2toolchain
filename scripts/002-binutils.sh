#!/bin/sh

 ## No patches needed...
 for TARGET in "ee"; do

  ## Unpack the source code.
  rm -Rf binutils-2.25 && tar xfj binutils-2.25.tar.bz2 || { exit 1; }

  cd binutils-2.25 || exit 1

  ## Create and enter the build directory.
  mkdir "build-$TARGET" && cd "build-$TARGET" || { exit 1; }

  ## Configure the build.
  ../configure --prefix="$PS2DEV/$TARGET" --target="mips64r5900el-ps2-elf" --program-prefix="$TARGET-" || { exit 1; }

  ## Compile and install.
  make -j8 && make install -j8 || { exit 1; }

  ## Exit the build directory.
  cd ../.. || { exit 1; }

 ## End target.
 done

 ## Patches needed...
 for TARGET in "iop"; do

  ## Unpack the source code.
  rm -Rf binutils-2.25 && tar xfj binutils-2.25.tar.bz2 || { exit 1; }

  ## Enter the source directory and patch the source code.
  cd binutils-2.25 && cat "../../patches/binutils-2.25-$TARGET-PS2.patch" | patch -p1 || { exit 1; }

  ## Create and enter the build directory.
  mkdir "build-$TARGET" && cd "build-$TARGET" || { exit 1; }

  ## Configure the build.
  ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" --program-prefix="$TARGET-" || { exit 1; }

  ## Compile and install.
  make -j8 && make install -j8 || { exit 1; }

  ## Exit the build directory.
  cd ../.. || { exit 1; }

 ## End target.
 done

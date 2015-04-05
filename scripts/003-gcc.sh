#!/bin/sh

 ## For each target...
 for TARGET in "ee"; do

  ## Unpack the source code.
  rm -Rf gcc-4.9.2 && tar xfj gcc-4.9.2.tar.bz2 || { exit 1; }

  ## Enter the source directory and patch the source code.
  cd gcc-4.9.2 && cat "../../patches/gcc-4.9.2-$TARGET-PS2.patch" | patch -p1 || { exit 1; }

  ## Create and enter the build directory.
  mkdir "build-$TARGET-stage1" && cd "build-$TARGET-stage1" || { exit 1; }

  ## Configure the build.
  ../configure --prefix="$PS2DEV/$TARGET" --target="mips64r5900el-ps2-elf" --program-prefix="$TARGET-" --enable-languages="c" --disable-nls --disable-shared --disable-libssp --disable-libmudflap --disable-threads --disable-libgomp --disable-libquadmath --disable-target-libiberty --disable-target-zlib --without-ppl --without-cloog --disable-libada --disable-libatomic --disable-multilib --with-headers=no  || { exit 1; }

  ## Compile and install.
  make -j8 && make install -j8 || { exit 1; }

  ## Exit the build directory.
  cd ../.. || { exit 1; }

 ## End target.
 done

 ## For each target...
 for TARGET in "iop"; do

  ## Unpack the source code.
  rm -Rf gcc-4.9.2 && tar xfj gcc-4.9.2.tar.bz2 || { exit 1; }

  ## Enter the source directory and patch the source code.
  cd gcc-4.9.2 && cat "../../patches/gcc-4.9.2-$TARGET-PS2.patch" | patch -p1 || { exit 1; }

  ## Create and enter the build directory.
  mkdir "build-$TARGET-stage1" && cd "build-$TARGET-stage1" || { exit 1; }

  ## Configure the build.
  ../configure --program-prefix="iop-" --prefix="$PS2DEV/iop" --target="iop" --enable-languages="c" --disable-libgcc --disable-nls --disable-shared --disable-libssp --disable-libmudflap --disable-threads --disable-libgomp --disable-libquadmath --disable-target-libiberty --disable-target-zlib --without-ppl --without-cloog --disable-libada --disable-libatomic --disable-multilib --with-headers=no

  ## Compile and install.
  make -j8 && make install -j8 || { exit 1; }

  ## Exit the build directory.
  cd ../.. || { exit 1; }

 ## End target.
 done

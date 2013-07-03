#!/bin/sh
# gcc-3.2.2-stage1.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 SOURCE=https://github.com/downloads/ps2dev/ps2toolchain/gcc-3.2.2.tar.bz2
 wget --continue --no-check-certificate $SOURCE || { exit 1; }

 GCC_VERSION=200583
 rm -Rf gcc-r${GCC_VERSION} || { exit 1; }
 svn checkout -r ${GCC_VERSION} svn://gcc.gnu.org/svn/gcc/trunk "gcc-r${GCC_VERSION}" || { exit 1; }

 ## Unpack the source code.
 rm -Rf gcc-3.2.2 && tar xfvj gcc-3.2.2.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd "gcc-r${GCC_VERSION}" || { exit 1; }

 ## For each target...
 for TARGET in "ee"; do

  ## Create and enter the build directory.
  mkdir "build-$TARGET-stage1" && cd "build-$TARGET-stage1" || { exit 1; }

  ## Configure the build.
  ../configure --prefix="$PS2DEV/ee" --target="mips64r5900el-ps2-elf" --program-prefix="$EE_TOOL_PREFIX" --enable-languages="c" --disable-nls --disable-shared --disable-libssp --disable-libmudflap --disable-threads --disable-libgomp --disable-libquadmath --disable-target-libiberty --disable-target-zlib --without-ppl --without-cloog --with-headers=no --disable-libada --disable-libatomic --disable-multilib || { exit 1; }

  ## Compile and install.
  make clean && make -j 2 && make install && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done

 cd ..

 ## Enter the source directory and patch the source code.
 cd gcc-3.2.2 && cat ../../patches/gcc-3.2.2-PS2.patch | patch -p1 || { exit 1; }

 ## For each target...
 for TARGET in "iop"; do

  ## Create and enter the build directory.
  mkdir "build-$TARGET-stage1" && cd "build-$TARGET-stage1" || { exit 1; }

  ## Configure the build.
  ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" --enable-languages="c" --with-newlib --without-headers || { exit 1; }

  ## Compile and install.
  make clean && make -j 2 && make install && make clean || { exit 1; }

  ## Exit the build directory.
  cd .. || { exit 1; }

 ## End target.
 done

#!/bin/sh
# gcc-3.2.3-stage1.sh by uyjulian
# gcc-4.9.3 by AKuHAK

 ## Download the source code.
 SOURCE=http://ftpmirror.gnu.org/gcc/gcc-3.2.3/gcc-3.2.3.tar.bz2
 wget --continue $SOURCE || { exit 1; }

 GCC_VERSION=4.9.3
 SOURCE2=http://ftpmirror.gnu.org/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.bz2
 wget --continue $SOURCE2 || { exit 1; }

 ## Unpack the source code.
 rm -Rf gcc-3.2.3 && tar xfj gcc-3.2.3.tar.bz2 || { exit 1; }
 rm -Rf gcc-${GCC_VERSION} && tar xfj gcc-${GCC_VERSION}.tar.bz2|| { exit 1; }

 ## Enter the source directory and patch the source code.
 cd gcc-3.2.3 && cat ../../patches/gcc-3.2.3-PS2.patch | patch -p1 || { exit 1; }

 ## Make the configure files
 autoreconf || { exit 1; }

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

 cd ..

 ## Enter the source directory and patch the source code.
 cd "gcc-${GCC_VERSION}" && cat ../../patches/gcc-${GCC_VERSION}-PS2.patch | patch -p1 || { exit 1; }

 # configure.ac was patched, need to update configure.
 cd libgcc || exit -1
 autoconf2.64 || exit -1
 cd .. || exit -1

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

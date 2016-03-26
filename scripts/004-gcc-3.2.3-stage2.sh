#!/bin/sh
# gcc-3.2.3-stage2.sh by uyjulian

 GCC_VERSION=3.2.3
 ## Download the source code.
 SOURCE=http://ftpmirror.gnu.org/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2
 wget --continue $SOURCE || { exit 1; }

 ## Unpack the source code.
 echo Decompressing GCC $GCC_VERSION. Please wait.
 rm -Rf gcc-$GCC_VERSION && tar xfj gcc-$GCC_VERSION.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd gcc-$GCC_VERSION || { exit 1; }
 if [ -e ../../patches/gcc-$GCC_VERSION-PS2.patch ]; then
 	cat ../../patches/gcc-$GCC_VERSION-PS2.patch | patch -p1 || { exit 1; }
 fi

 ## Make the configure files
 autoreconf || { exit 1; }

 TARGET="ee"
 ## Create and enter the build directory.
 mkdir build-$TARGET-stage2 && cd build-$TARGET-stage2 || { exit 1; }

 ## Configure the build.
if [ "$(uname)" == "Darwin" ]; then
  ../configure --prefix="$PS2DEV/ee" --target="ee" --build=i386-linux-gnu --host=i386-linux-gnu --enable-languages="c,c++" --with-newlib --with-headers="$PS2DEV/ee/ee/include" --enable-cxx-flags="-G0" || { exit 1; }
else
  ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" --enable-languages="c,c++" --with-newlib --with-headers="$PS2DEV/$TARGET/$TARGET/include" || { exit 1; }
fi

 ## Compile and install.
 make clean && make -j $(nproc) && make install && make clean || { exit 1; }

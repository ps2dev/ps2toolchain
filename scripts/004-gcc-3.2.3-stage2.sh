#!/bin/bash
# gcc-3.2.3-stage2.sh by uyjulian
# Based on gcc-3.2.2-stage2.sh by Dan Peori (danpeori@oopo.net)

GCC_VERSION=3.2.3
SOURCE=http://ftpmirror.gnu.org/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2

 ## Download the source code.
 echo "Downloading gcc-$GCC_VERSION source code."
 wget --continue $SOURCE || { exit 1; }

 ## Unpack the source code.
 echo "Decompressing gcc-$GCC_VERSION."
 rm -Rf gcc-$GCC_VERSION && tar xfj gcc-$GCC_VERSION.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd gcc-$GCC_VERSION || { exit 1; }
 if [ -e ../../patches/gcc-$GCC_VERSION-PS2.patch ]; then
   cat ../../patches/gcc-$GCC_VERSION-PS2.patch | patch -p1 || { exit 1; }
 fi

 ## Apple needs to pretend to be linux
 OSVER=$(uname)
 if [ ${OSVER:0:6} == Darwin ]; then
   TARG_XTRA_OPTS="--build=i386-linux-gnu --host=i386-linux-gnu --enable-cxx-flags=-G0"
 else
   TARG_XTRA_OPTS=""
 fi

 ## For target...
 TARGET="ee"

 ## Create and enter the build directory.
 echo "Building gcc-$TARGET-stage2..."
 mkdir build-$TARGET-stage2 && cd build-$TARGET-stage2 || { exit 1; }

 ## Configure the build.
 ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" --enable-languages="c,c++" --with-newlib --with-headers="$PS2DEV/$TARGET/$TARGET/include" $TARG_XTRA_OPTS || { exit 1; }

 ## Compile and install.
 make clean && make -j $PROC_NR && make install && make clean || { exit 1; }

 ## Exit the build directory.
 cd .. || { exit 1; }

#!/bin/sh
# gcc-3.2.3-stage2.sh by uyjulian

 ## Newlib build not needed with GCC 4.9
 exit 0

 ## Download the source code.
 SOURCE=http://ftpmirror.gnu.org/gcc/gcc-3.2.3/gcc-3.2.3.tar.bz2
 wget --continue --no-check-certificate $SOURCE || { exit 1; }

 ## Unpack the source code.
 rm -Rf gcc-3.2.3 && tar xfj gcc-3.2.3.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd gcc-3.2.3 && cat ../../patches/gcc-3.2.3-PS2.patch | patch -p1 || { exit 1; }

 ## Make the configure files.
 autoreconf || { exit 1; }

 ## Create and enter the build directory.
 mkdir build-ee-stage2 && cd build-ee-stage2 || { exit 1; }

 ## Configure the build.
 ../configure --prefix="$PS2DEV/ee" --target="ee" --enable-languages="c,c++" --with-newlib --with-headers="$PS2DEV/ee/ee/include" || { exit 1; }

 ## Compile and install.
 make clean && make -j 2 && make install && make clean || { exit 1; }

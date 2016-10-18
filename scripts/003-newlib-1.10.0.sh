#!/bin/bash
# newlib-1.10.0.sh by Dan Peori (danpeori@oopo.net)

NEWLIB_VERSION=1.10.0
SOURCE=ftp://sourceware.org/pub/newlib/newlib-$NEWLIB_VERSION.tar.gz

 ## Download the source code.
 echo "Downloading newlib-$NEWLIB_VERSION source code."
 wget --continue $SOURCE || { exit 1; }

 ## Unpack the source code.
 echo "Decompressing newlib-$NEWLIB_VERSION."
 rm -Rf newlib-$NEWLIB_VERSION && tar xfz newlib-$NEWLIB_VERSION.tar.gz || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd newlib-$NEWLIB_VERSION || { exit 1; }
 if [ -e ../../patches/newlib-$NEWLIB_VERSION-PS2.patch ]; then
   cat ../../patches/newlib-$NEWLIB_VERSION-PS2.patch | patch -p1 || { exit 1; }
 fi

 ## For target...
 TARGET="ee"

 ## Create and enter the build directory.
 echo "Building newlib-$TARGET..."
 mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

 ## Configure the build.
 ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }

 ## Compile and install.
 make clean && make -j $PROC_NR && make install && make clean || { exit 1; }

 ## Exit the build directory.
 cd .. || { exit 1; }

#!/bin/sh
# newlib-1.10.0.sh by Dan Peori (danpeori@oopo.net)

 NEWLIB_VERSION=1.10.0
 ## Download the source code.
 SOURCE=ftp://sourceware.org/pub/newlib/newlib-$NEWLIB_VERSION.tar.gz
 wget --continue $SOURCE || { exit 1; }

 ## Unpack the source code.
 echo Decompressing newlib $NEWLIB_VERSION. Please wait.
 rm -Rf newlib-$NEWLIB_VERSION && tar xfz newlib-$NEWLIB_VERSION.tar.gz || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd newlib-$NEWLIB_VERSION || { exit 1; }
 if [ -e ../../patches/newlib-$NEWLIB_VERSION-PS2.patch ]; then
 	cat ../../patches/newlib-$NEWLIB_VERSION-PS2.patch | patch -p1 || { exit 1; }
 fi

 ## OS Windows doesn't properly work with multi-core processors
 if [ $(uname) == MINGW32_NT* ]; then
 	PROC_NR=2
 else
 	PROC_NR=$(nproc)
 fi

 TARGET="ee"
 ## Create and enter the build directory.
 mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

 ## Configure the build.
 ../configure --prefix="$PS2DEV/$TARGET" --target="$TARGET" || { exit 1; }

 ## Compile and install.
 make clean && make -j $PROC_NR && make install && make clean || { exit 1; }

#!/bin/sh

 ## Unpack the source code.
 rm -Rf newlib-2.2.0 && tar xfz newlib-2.2.0.tar.gz || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd newlib-2.2.0 && cat ../../patches/newlib-2.2.0-ee-PS2.patch | patch -p1 || { exit 1; }

 ## Create and enter the build directory.
 mkdir build-ee && cd build-ee || { exit 1; }

 ## Configure the build.
 ../configure --prefix="$PS2DEV/ee" --target="ee" || { exit 1; }

 ## Compile and install.
 make -j8 && make install -j8 || { exit 1; }

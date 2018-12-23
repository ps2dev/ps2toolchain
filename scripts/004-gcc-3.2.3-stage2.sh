#!/bin/bash
# gcc-3.2.3-stage2.sh by uyjulian
# Based on gcc-3.2.2-stage2.sh by Naomi Peori (naomi@peori.ca)

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
cat ../../patches/gcc-$GCC_VERSION-disable-warnings.patch | patch -p0 || { exit 1; }

OSVER=$(uname)
## Apple needs to pretend to be linux
if [ ${OSVER:0:6} == Darwin ]; then
	TARG_XTRA_OPTS="--build=i386-linux-gnu --host=i386-linux-gnu --enable-cxx-flags=-G0"
else
	TARG_XTRA_OPTS="--enable-cxx-flags=-G0"
fi

## Determine the maximum number of processes that Make can work with.
if [ ${OSVER:0:10} == MINGW32_NT ]; then
	PROC_NR=$NUMBER_OF_PROCESSORS
elif [ ${OSVER:0:6} == Darwin ]; then
	PROC_NR=$(sysctl -n hw.ncpu)
else
	PROC_NR=$(nproc)
fi

echo "Building with $PROC_NR jobs"

TARGET="ee"
## Create and enter the build directory.
mkdir build-$TARGET-stage2 && cd build-$TARGET-stage2 || { exit 1; }

## Configure the build.
../configure --quiet --prefix="$PS2DEV/$TARGET" --target="$TARGET" --enable-languages="c,c++" --with-newlib --with-headers="$PS2DEV/$TARGET/$TARGET/include" $TARG_XTRA_OPTS || { exit 1; }

## Compile and install.
make --quiet clean && make --quiet -j $PROC_NR && make --quiet install && make --quiet clean || { exit 1; }

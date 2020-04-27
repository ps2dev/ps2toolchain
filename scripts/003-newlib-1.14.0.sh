#!/bin/bash
# newlib-1.14.0.sh by Naomi Peori (naomi@peori.ca)

NEWLIB_VERSION=1.14.0
## Download the source code.
SOURCE=http://mirrors.kernel.org/sourceware/newlib/newlib-$NEWLIB_VERSION.tar.gz
wget --continue $SOURCE || { exit 1; }

## Unpack the source code.
echo Decompressing newlib $NEWLIB_VERSION. Please wait.
rm -Rf newlib-$NEWLIB_VERSION && tar xfz newlib-$NEWLIB_VERSION.tar.gz || { exit 1; }

## Enter the source directory and patch the source code.
cd newlib-$NEWLIB_VERSION || { exit 1; }
if [ -e ../../patches/newlib-$NEWLIB_VERSION-PS2.patch ]; then
	cat ../../patches/newlib-$NEWLIB_VERSION-PS2.patch | patch -p1 || { exit 1; }
fi

OSVER=$(uname)
if [ ${OSVER:0:10} == MINGW64_NT ]; then
	TARG_XTRA_OPTS="--build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32"
else
	TARG_XTRA_OPTS=""
fi

## Determine the maximum number of processes that Make can work with.
if [ ${OSVER:0:5} == MINGW ]; then
	PROC_NR=$NUMBER_OF_PROCESSORS
elif [ ${OSVER:0:6} == Darwin ]; then
	PROC_NR=$(sysctl -n hw.ncpu)
else
	PROC_NR=$(nproc)
fi

TARGET="ee"
## Create and enter the build directory.
mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

## Configure the build.
../configure --quiet --prefix="$PS2DEV/$TARGET" --target="$TARGET" $TARG_XTRA_OPTS || { exit 1; }

## Compile and install.
make --quiet clean && CPPFLAGS="-G0" make --quiet -j $PROC_NR && make --quiet install && make --quiet clean || { exit 1; }

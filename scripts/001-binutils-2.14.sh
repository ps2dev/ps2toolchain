#!/bin/bash
# binutils-2.14.sh by Naomi Peori (naomi@peori.ca)

BINUTILS_VERSION=2.14
## Download the source code.
SOURCE=http://ftpmirror.gnu.org/binutils/binutils-$BINUTILS_VERSION.tar.bz2
wget --continue $SOURCE || { exit 1; }

## Unpack the source code.
echo Decompressing Binutils $BINUTILS_VERSION. Please wait.
rm -Rf binutils-$BINUTILS_VERSION && tar xfj binutils-$BINUTILS_VERSION.tar.bz2 || { exit 1; }

## Enter the source directory and patch the source code.
cd binutils-$BINUTILS_VERSION || { exit 1; }
if [ -e ../../patches/binutils-$BINUTILS_VERSION-PS2.patch ]; then
	cat ../../patches/binutils-$BINUTILS_VERSION-PS2.patch | patch -p1 || { exit 1; }
fi
cat ../../patches/binutils-$BINUTILS_VERSION-add-64bit-mingw-w64-toolchain-support.patch | patch -p1 || { exit 1; }

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

echo "Building with $PROC_NR jobs"

## For each target...
for TARGET in "ee" "iop" "dvp"; do
	## Create and enter the build directory.
	mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

	## Configure the build.
	if [ ${OSVER:0:6} == Darwin ]; then
		CC=/usr/bin/gcc CXX=/usr/bin/g++ LD=/usr/bin/ld CFLAGS="-O0 -ansi -Wno-implicit-int -Wno-return-type" ../configure --quiet --disable-build-warnings --prefix="$PS2DEV/$TARGET" --target="$TARGET" $TARG_XTRA_OPTS || { exit 1; }
	else
		../configure --quiet --disable-build-warnings --prefix="$PS2DEV/$TARGET" --target="$TARGET" $TARG_XTRA_OPTS || { exit 1; }
	fi

	## Compile and install.
	make --quiet clean && make --quiet -j $PROC_NR CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=0" && make --quiet install && make --quiet clean || { exit 1; }

	## Exit the build directory.
	cd .. || { exit 1; }

	## End target.
done

#!/bin/sh

 for SOURCE in "http://ftpmirror.gnu.org/binutils/binutils-2.25.tar.bz2" "http://ftpmirror.gnu.org/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2" "ftp://sourceware.org/pub/newlib/newlib-2.2.0.tar.gz"; do
  wget --continue $SOURCE || { exit 1; }
 done

 ## Git source code...
 if test ! -d "ps2sdk"; then
  git clone git://github.com/ps2dev/ps2sdk.git && cd ps2sdk || exit 1
 else
  cd ps2sdk &&
  git fetch origin &&
  git reset --hard origin/master || exit 1
 fi

 if test ! -d "ps2client"; then
  git clone git://github.com/ps2dev/ps2client.git && cd ps2client || exit 1
 else
  cd ps2client &&
  git fetch origin &&
  git reset --hard origin/master || exit 1
 fi
#!/bin/sh
# toolchain-oldiop.sh - Dan Peori <peori@oopo.net>
# Copy all you want. Please give me some credit.

 ########################
 ## MAIN CONFIGURATION ##
 ########################

  ## Main ps2dev settings.
  export PS2DEV="/usr/local/ps2dev"
  export PATH="$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin"

  ## Check for which make to use.
  export MAKE="gmake"; $MAKE -v || { export MAKE="make"; }

  ## Check for make.
  $MAKE -v || { echo "ERROR: Please make sure you have GNU 'make' installed."; exit; }

  ## Check for patch.
  patch -v || { echo "ERROR: Please make sure you have 'patch' installed."; exit; }

  ## Check for wget.
  wget -V || { echo "ERROR: Please make sure you have 'wget' installed."; exit; }

  ## Download the source.
  wget -c ftp://ftp.gnu.org/pub/gnu/binutils/binutils-2.9.1.tar.gz
  wget -c ftp://ftp.gnu.org/pub/gnu/gcc/gcc-2.8.1.tar.gz

  ## Remove the current IOP installation.
  rm -Rf $PS2DEV/iop

 ################################
 ## BUILD AND INSTALL BINUTILS ##
 ################################

  ## Unpack the source.
  rm -Rf binutils-2.9.1; tar xfvz binutils-2.9.1.tar.gz || { echo "ERROR UNPACKING BINUTILS"; exit; }

  ## Patch the source.
  cd binutils-2.9.1; cat ../binutils-2.9.1-IOP.patch | patch -p1 || { echo "ERROR PATCHING BINUTILS"; exit; }

  ## Configure the build.
  mkdir build-iop; cd build-iop; ../configure --prefix=$PS2DEV/iop --target=iop || { echo "ERROR CONFIGURING BINUTILS"; exit; }

  ## Build the source.
  $MAKE clean; $MAKE || { echo "ERROR BUILDING BINUTILS"; exit; }

  ## Install the build.
  $MAKE install || { echo "ERROR INSTALLING BINUTILS"; exit; }

  ## Clean up the result.
  cd ../..; rm -Rf binutils-2.9.1

 ###########################
 ## BUILD AND INSTALL GCC ##
 ###########################

  ## Unpack the source.
  rm -Rf gcc-2.8.1; tar xfvz gcc-2.8.1.tar.gz || { echo "ERROR UNPACKING GCC"; exit; }

  ## Patch the source.
  cd gcc-2.8.1; cat ../gcc-2.8.1-IOP.patch | patch -p1 || { echo "ERROR PATCHING GCC"; exit; }

  ## Configure the build.
  mkdir build-iop; cd build-iop; ../configure --prefix=$PS2DEV/iop --target=iop --enable-languages="c" --with-newlib --without-headers || { echo "ERROR CONFIGURING GCC"; exit; }

  ## Build the source.
  $MAKE clean; $MAKE || { echo "ERROR BUILDING GCC"; exit; }

  ## Install the build.
  $MAKE install || { echo "ERROR INSTALLING GCC"; exit; }

  ## Clean up the result.
  cd ../..; rm -Rf gcc-2.8.1

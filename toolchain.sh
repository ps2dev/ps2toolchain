#!/bin/sh
# toolchain.sh - Dan Peori <peori@oopo.net>
# Copy all you want. Please give me some credit.

 ########################
 ## MAIN CONFIGURATION ##
 ########################

  ## Main ps2dev settings.
  export PS2DEV="/usr/local/ps2dev"
  export PS2SDK="$PS2DEV/ps2sdk"
  export CVSROOT=":pserver:anonymous@cvs.ps2dev.org:2401/home/ps2cvs"
  export PATH="$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin"

  ## Set the directories.
  export SRCDIR="`pwd`"
  export TMPDIR="/tmp/ps2dev"

  ## Source code versions.
  export BINUTILS="binutils-2.14"
  export GCC="gcc-3.2.2"
  export NEWLIB="newlib-1.10.0"

  ## CVS configuration.
  if [ -z "`cat ~/.cvspass | grep $CVSROOT`" ]; then
   echo "THE SECRET PASSWORD IS: anonymous"
   cvs -d $CVSROOT login
  fi

 ###########################
 ## SOFTWARE DEPENDENCIES ##
 ###########################

  ## Check for which make to use.
  export MAKE="gmake"; $MAKE -v || { export MAKE="make"; }

  ## Check for make.
  $MAKE -v || { echo "ERROR: Please make sure you have GNU 'make' installed."; exit; }

  ## Check for patch.
  patch -v || { echo "ERROR: Please make sure you have 'patch' installed."; exit; }

  ## Check for wget.
  wget -V || { echo "ERROR: Please make sure you have 'wget' installed."; exit; }

 ################################
 ## DOWNLOAD, UNPACK AND PATCH ##
 ################################

  ## Download the source.
  wget -c ftp://ftp.gnu.org/pub/gnu/binutils/$BINUTILS.tar.gz
  wget -c ftp://ftp.gnu.org/pub/gnu/gcc/$GCC.tar.gz
  wget -c ftp://sources.redhat.com/pub/newlib/$NEWLIB.tar.gz

  ## Create the build directory.
  mkdir -p $TMPDIR; cd $TMPDIR

  ## Unpack the source.
  rm -Rf $BINUTILS; tar xfvz $SRCDIR/$BINUTILS.tar.gz
  rm -Rf $GCC; tar xfvz $SRCDIR/$GCC.tar.gz
  rm -Rf $NEWLIB; tar xfvz $SRCDIR/$NEWLIB.tar.gz

  ## Patch the source.
  cd $BINUTILS; cat $SRCDIR/$BINUTILS.patch | patch -p1; cd ..
  cd $GCC; cat $SRCDIR/$GCC.patch | patch -p1; cd ..
  cd $NEWLIB; cat $SRCDIR/$NEWLIB.patch | patch -p1; cd ..

 ################################
 ## BUILD AND INSTALL BINUTILS ##
 ################################

  ## Enter the source directory.
  cd $BINUTILS

  ## Build for each target.
  for TARGET in "ee" "iop" "dvp"; do

   ## Create the build directory.
   mkdir build-$TARGET

   ## Enter the build directory.
   cd build-$TARGET

   ## Configure the source.
   ../configure --prefix=$PS2DEV/$TARGET --target=$TARGET || { echo "ERROR CONFIGURING BINUTILS ($BINUTILS $TARGET)"; exit; }

   ## Build the source.
   $MAKE clean; $MAKE || { echo "ERROR BUILDING BINUTILS ($BINUTILS $TARGET)"; exit; }

   ## Install the result.
   $MAKE install || { echo "ERROR INSTALLING BINUTILS ($BINUTILS $TARGET)"; exit; }

   ## Clean up the result.
   $MAKE clean

   ## Exit the build directory.
   cd ..

  ## End of the target build.
  done

  ## Exit the source directory.
  cd ..

 ###########################
 ## BUILD AND INSTALL GCC ##
 ###########################

  ## Enter the source directory.
  cd $GCC

  ## Build for each target.
  for TARGET in "ee" "iop"; do

   ## Create the build directory.
   mkdir build-$TARGET

   ## Enter the build directory.
   cd build-$TARGET

   ## Configure the source.
   ../configure --prefix=$PS2DEV/$TARGET --target=$TARGET --enable-languages="c" --with-newlib --without-headers || { echo "ERROR CONFIGURING GCC ($GCC $TARGET)"; exit; }

   ## Build the source.
   $MAKE clean; $MAKE || { echo "ERROR BUILDING GCC ($GCC $TARGET)"; exit; }

   ## Install the result.
   $MAKE install || { echo "ERROR INSTALLING GCC ($GCC $TARGET)"; exit; }

   ## Clean up the result.
   $MAKE clean

   ## Exit the build directory.
   cd ..

  ## End of the target build.
  done

  ## Exit the source directory.
  cd ..

 ##############################
 ## BUILD AND INSTALL NEWLIB ##
 ##############################

  ## Enter the source directory.
  cd $NEWLIB

  ## Build for each target.
  for TARGET in "ee"; do

   ## Create the build directory.
   mkdir build-$TARGET

   ## Enter the build directory.
   cd build-$TARGET

   ## Configure the source.
   ../configure --prefix=$PS2DEV/$TARGET --target=$TARGET || { echo "ERROR CONFIGURING NEWLIB ($NEWLIB $TARGET)"; exit; }

   ## Build the source.
   $MAKE clean; CPPFLAGS="-G0" $MAKE || { echo "ERROR BUILDING NEWLIB ($NEWLIB $TARGET)"; exit; }

   ## Install the result.
   $MAKE install || { echo "ERROR INSTALLING NEWLIB ($NEWLIB $TARGET)"; exit; }

   ## Clean up the result.
   $MAKE clean

   ## Exit the build directory.
   cd ..

  ## End of the target build.
  done

  ## Exit the source directory.
  cd ..

 #################################
 ## BUILD AND INSTALL GCC (C++) ##
 #################################

  ## Enter the source directory.
  cd $GCC

  ## Build for each target.
  for TARGET in "ee"; do

   ## Create the build directory.
   mkdir build-$TARGET-c++

   ## Enter the build directory.
   cd build-$TARGET-c++

   ## Configure the source.
   ../configure --prefix=$PS2DEV/$TARGET --target=$TARGET --enable-languages="c,c++" --with-newlib --with-headers=$PS2DEV/$TARGET/$TARGET/include --enable-cxx-flags="-G0" || { echo "ERROR CONFIGURING GCC ($GCC $TARGET C++)"; exit; }

   ## Build the source.
   $MAKE clean; $MAKE CFLAGS_FOR_TARGET="-G0" || { echo "ERROR BUILDING GCC ($GCC $TARGET C++)"; exit; }

   ## Install the result.
   $MAKE install || { echo "ERROR INSTALLING GCC ($GCC $TARGET C++)"; exit; }

   ## Clean up the result.
   $MAKE clean

   ## Exit the build directory.
   cd ..

  ## End of the target build.
  done

  ## Exit the source directory.
  cd ..

 #################################
 ## BUILD AND INSTALL PS2CLIENT ##
 #################################

  ## Remove any previous builds.
  rm -Rf ps2client

  ## Check out the latest source.
  cvs -d $CVSROOT checkout ps2client

  ## Enter the source directory.
  cd ps2client

  ## Build the source.
  $MAKE clean; $MAKE || { echo "ERROR BUILDING PS2CLIENT"; exit; }

  ## Install the result.
  $MAKE install || { echo "ERROR INSTALLING PS2CLIENT"; exit; }

  ## Clean up the result.
  $MAKE clean

  ## Exit the source directory.
  cd ..

 ##############################
 ## BUILD AND INSTALL PS2SDK ##
 ##############################

  ## Remove any previous builds.
  rm -Rf ps2sdk

  ## Check out the latest source.
  cvs -d $CVSROOT checkout ps2sdk

  ## Enter the source directory.
  cd ps2sdk

  ## Configure the source.
  export PS2SDKSRC="`pwd`"

  ## Build the source.
  $MAKE clean; $MAKE || { echo "ERROR BUILDING PS2SDK"; exit; }

  ## Install the result.
  $MAKE release || { echo "ERROR INSTALLING PS2SDK"; exit; }
  
  ## Replace newlib's crt0 with the one in ps2sdk.
  ln -sf $PS2SDK/ee/startup/crt0.o $PS2DEV/ee/lib/gcc-lib/ee/3.2.2/
  ln -sf $PS2SDK/ee/startup/crt0.o $PS2DEV/ee/ee/lib/

  ## Clean up the result.
  $MAKE clean

  ## Exit the source directory.
  cd ..

 #########################
 ## CLEAN UP THE RESULT ##
 #########################

  ## Clean up binutils.
  rm -Rf $BINUTILS

  ## Clean up gcc.
  rm -Rf $GCC

  ## Clean up newlib.
  rm -Rf $NEWLIB

  ## Clean up ps2client.
  rm -Rf ps2client

  ## Clean up ps2sdk.
  rm -Rf ps2sdk

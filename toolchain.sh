#!/bin/sh
# toolchain.sh - Dan Peori <peori@oopo.net>
# Copy all you want. Please give me some credit.

 ########################
 ## MAIN CONFIGURATION ##
 ########################

  ## Main ps2dev settings.
  export PS2DEV="/usr/local/ps2dev"
  export PS2SDK="$PS2DEV/ps2sdk"
  export PATH="$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin"

  ## Set the directories.
  export SRCDIR="`pwd`"
  export TMPDIR="/tmp/ps2dev"

  ## Source code versions.
  export BINUTILS="binutils-2.14"
  export GCC="gcc-3.2.2"
  export NEWLIB="newlib-1.10.0"

 #########################
 ## PARSE THE ARGUMENTS ##
 #########################

  ## If no arguments are given...
  if test $# -eq 0 ; then

   ## Do everything possible.
   DO_DOWNLOAD=1
   BUILD_BINUTILS=1
   BUILD_GCC=1
   BUILD_NEWLIB=1
   BUILD_PS2SDK=1

  ## Else...
  else

   ## Parse the arguments.
   while test $# -ge 1 ; do
    case "$1" in
     -d)
      DO_DOWNLOAD=1
      shift;;
     -b)
      BUILD_BINUTILS=1
      shift;;
     -g)
      BUILD_GCC=1
      shift;;
     -n)
      BUILD_NEWLIB=1
      shift;;
     -p)
      BUILD_PS2SDK=1
      shift;;
    esac
   done

  fi

 ###########################
 ## SOFTWARE DEPENDENCIES ##
 ###########################

  ## Check for make.
  if test "`gmake -v`" ; then
   MAKE="gmake"
  else
   if test "`make -v`" ; then
    MAKE="make"
   else
    echo "ERROR: Please make sure you have GNU 'make' installed."
    exit
   fi
  fi

  ## Check for patch.
  if test "`patch -v`" ; then
   PATCH="patch -p0"
  else
   echo "ERROR: Please make sure you have 'patch' installed."
   exit
  fi

  ## Check for wget.
  if test "`wget -V`" ; then
   WGET="wget --passive-ftp"
  else
   echo "ERROR: Please make sure you have 'wget' installed."
   exit
  fi

  ## Check for subversion.
  if test "`svn help`" ; then
   SVN="svn"
  else
   echo "ERROR: Please make sure you have 'subversion (svn)' installed."
   exit
  fi

  ## Check for write permission.
  mkdir -p $PS2SDK || { echo "ERROR: Please make sure you're root."; exit; }
  touch $PS2SDK/test-write-perm-$$ || { echo "ERROR: Please make sure you're root."; exit; }
  rm $PS2SDK/test-write-perm-$$

 ################################
 ## DOWNLOAD, UNPACK AND PATCH ##
 ################################

  ## If we've been told to download...
  if test $DO_DOWNLOAD ; then

   ## Download the binutils source.
   if test $BUILD_BINUTILS ; then
    if test ! -f "$BINUTILS.tar.gz" ; then
     $WGET ftp://ftp.gnu.org/pub/gnu/binutils/$BINUTILS.tar.gz || { echo "ERROR DOWNLOADING BINUTILS"; exit; }
    fi
   fi

   ## Download the gcc source.
   if test $BUILD_GCC ; then
    if test ! -f "$GCC.tar.gz" ; then
     $WGET ftp://ftp.gnu.org/pub/gnu/gcc/$GCC.tar.gz || { echo "ERROR DOWNLOADING GCC"; exit; }
    fi
   fi

   ## Download the newlib source.
   if test $BUILD_NEWLIB ; then
    if test ! -f "$NEWLIB.tar.gz" ; then
     $WGET ftp://sources.redhat.com/pub/newlib/$NEWLIB.tar.gz || { echo "ERROR DOWNLOADING NEWLIB"; exit; }
    fi
   fi

  fi

  ## Create and enter the temp directory.
  mkdir -p "$TMPDIR"; cd "$TMPDIR"

  ## Unpack and patch the binutils source.
  if test $BUILD_BINUTILS ; then
   rm -Rf $BINUTILS; tar xfvz "$SRCDIR/$BINUTILS.tar.gz"
   cd $BINUTILS; cat "$SRCDIR/$BINUTILS.patch" | $PATCH || { echo "ERROR PATCHING BINUTILS"; exit; }
   cd ..
  fi

  ## Unpack and patch the gcc source.
  if test $BUILD_GCC ; then
   rm -Rf $GCC; tar xfvz "$SRCDIR/$GCC.tar.gz"
   cd $GCC; cat "$SRCDIR/$GCC.patch" | $PATCH || { echo "ERROR PATCHING GCC"; exit; }
   cd ..
   cd $GCC; cat "$SRCDIR/gcc-restrict.patch" | patch -p1 || { echo "ERROR PATCHING GCC"; exit; }
   cd ..
  fi

  ## Unpack and patch the newlib source.
  if test $BUILD_NEWLIB ; then
   rm -Rf $NEWLIB; tar xfvz "$SRCDIR/$NEWLIB.tar.gz"
   cd $NEWLIB; cat "$SRCDIR/$NEWLIB.patch" | patch -p1 || { echo "ERROR PATCHING NEWLIB"; exit; }
   cd ..
  fi

 ################################
 ## BUILD AND INSTALL BINUTILS ##
 ################################

  ## If we've been told to build binutils...
  if test $BUILD_BINUTILS ; then

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

  fi

 ###########################
 ## BUILD AND INSTALL GCC ##
 ###########################

  ## If we've been told to build gcc...
  if test $BUILD_GCC ; then

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

  fi

 ##############################
 ## BUILD AND INSTALL NEWLIB ##
 ##############################

  ## If we've been told to build newlib...
  if test $BUILD_NEWLIB ; then

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

  fi

 #################################
 ## BUILD AND INSTALL GCC (C++) ##
 #################################

  ## If we've been told to build gcc...
  if test $BUILD_GCC ; then

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

  fi

 #################################
 ## BUILD AND INSTALL PS2CLIENT ##
 #################################

  ## If we've been told to build ps2sdk...
  if test $BUILD_PS2SDK ; then

   ## Remove any previous builds.
   rm -Rf ps2client

   ## Check out the latest source.
   $SVN checkout svn://svn.ps2dev.org/ps2/trunk/ps2client

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

  fi

 ##############################
 ## BUILD AND INSTALL PS2SDK ##
 ##############################

  ## If we've been told to build ps2sdk...
  if test $BUILD_PS2SDK ; then

   ## Remove any previous builds.
   rm -Rf ps2sdk

   ## Check out the latest source.
   $SVN checkout svn://svn.ps2dev.org/ps2/trunk/ps2sdk

   ## Enter the source directory.
   cd ps2sdk

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

  fi

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

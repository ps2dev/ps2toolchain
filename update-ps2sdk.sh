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

 ################################
 ## DOWNLOAD, UNPACK AND PATCH ##
 ################################

  ## Create the build directory.
  mkdir -p $TMPDIR; cd $TMPDIR

 ##############################
 ## BUILD AND INSTALL PS2SDK ##
 ##############################

  ## Remove the old ps2sdk.
  rm -Rf $PS2SDK

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

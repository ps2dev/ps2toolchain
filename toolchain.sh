#!/bin/bash
# toolchain.sh by Dan Peori (danpeori@oopo.net)

 ## Enter the ps2toolchain directory.
 cd "`dirname $0`" || { echo "ERROR: Could not enter the ps2toolchain directory."; exit 1; }

export PS2TOOLCHAIN_ROOT="$PWD"
export BUILD_DIR=${BUILD_DIR:-$PS2TOOLCHAIN_ROOT/build}
export DOWNLOAD_DIR=${DOWNLOAD_DIR:-$PS2TOOLCHAIN_ROOT/downloads}
[ -d "$DOWNLOAD_DIR" -o -L "$DOWNLOAD_DIR" ] || mkdir -p "$DOWNLOAD_DIR"

 ## Create the build directory.
 mkdir -p "$BUILD_DIR" || { echo "ERROR: Could not create the build directory."; exit 1; }

 ## Enter the build directory.
 cd "$BUILD_DIR" || { echo "ERROR: Could not enter the build directory."; exit 1; }

 ## Fetch the depend scripts.
 DEPEND_SCRIPTS=(`ls "$PS2TOOLCHAIN_ROOT"/depends/*.sh | sort`)

 ## Run all the depend scripts.
 for SCRIPT in ${DEPEND_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done

 ## Fetch the build scripts.
 BUILD_SCRIPTS=(`ls "$PS2TOOLCHAIN_ROOT"/scripts/*.sh | sort`)

 ## If specific steps were requested...
 if [ $1 ]; then

  ## Run the requested build scripts.
  for STEP in $@; do "${BUILD_SCRIPTS[$STEP-1]}" || { echo "${BUILD_SCRIPTS[$STEP-1]}: Failed."; exit 1; } done

 else

  ## Run the all build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done

 fi

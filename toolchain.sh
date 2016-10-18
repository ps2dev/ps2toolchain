#!/bin/bash
# toolchain.sh by Dan Peori (danpeori@oopo.net)

 ## Enter the ps2toolchain directory.
 cd "`dirname $0`" || { echo "ERROR: Could not enter the ps2toolchain directory."; exit 1; }

 ## Create the build directory.
 mkdir -p build || { echo "ERROR: Could not create the build directory."; exit 1; }

 ## Enter the build directory.
 cd build || { echo "ERROR: Could not enter the build directory."; exit 1; }

 ## Determine the maximum number of processes that Make can work with.
 ## MinGW's Make doesn't work properly with multi-core processors.
 OSVER=$(uname)
 if [ ${OSVER:0:10} == MINGW32_NT ]; then
  export PROC_NR=2
 elif [ ${OSVER:0:6} == Darwin ]; then
  export PROC_NR=$(sysctl -n hw.ncpu)
 else
  export PROC_NR=$(nproc)
 fi

 ## Fetch the depend scripts.
 DEPEND_SCRIPTS=(`ls ../depends/*.sh | sort`)

 ## Run all the depend scripts.
 for SCRIPT in ${DEPEND_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done

 ## Fetch the build scripts.
 BUILD_SCRIPTS=(`ls ../scripts/*.sh | sort`)

 ## If specific steps were requested...
 if [ $1 ]; then

  ## Run the requested build scripts.
  for STEP in $@; do "${BUILD_SCRIPTS[$STEP-1]}" || { echo "${BUILD_SCRIPTS[$STEP-1]}: Failed."; exit 1; } done

 else

  ## Run the all build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done

 fi

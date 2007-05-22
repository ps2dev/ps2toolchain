#!/bin/sh
# toolchain.sh by Dan Peori (danpeori@oopo.net)

 ## Create the build directory.
 mkdir -p `dirname $0`/build || { echo "ERROR: Could not create the build directory."; exit 1; }

 ## Enter the build directory.
 cd `dirname $0`/build || { echo "ERROR: Could not enter the build directory."; exit 1; }

 ## Run the depend scripts.
 for SCRIPT in `ls ../depends/*.sh | sort`; do $SCRIPT || { echo "$SCRIPT: Failed."; exit 1; } done

 ## Run the build scripts.
 for SCRIPT in `ls ../scripts/*.sh | sort`; do $SCRIPT || { echo "$SCRIPT: Failed."; exit 1; } done

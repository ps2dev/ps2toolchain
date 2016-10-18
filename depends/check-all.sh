#!/bin/sh
# check-all.sh by Caio Oliveira <caiooliveirafarias0@gmail.com>

 ## Check for each target...
 for TARGET in "autoreconf" "gcc" "git" "make" "patch" "wget"; do

  ## Check targets via which command
  which $TARGET 1> /dev/null || { echo "ERROR: Install $TARGET before continuing."; exit 1; }

 ## End target.
 done

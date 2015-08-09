#!/bin/sh
# check-gcc.sh by AKuHAK

 ## Check for libgmp3-dev
 ldconfig -p | grep libgmp3-dev 1> /dev/null || { echo "ERROR: Install libgmp3-dev before continuing."; exit 1; }

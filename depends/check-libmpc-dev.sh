#!/bin/sh
# check-gcc.sh by AKuHAK

 ## Check for libmpc-dev
 ldconfig -p | grep libmpc-dev 1> /dev/null || { echo "ERROR: Install libmpc-dev before continuing."; exit 1; }

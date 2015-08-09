#!/bin/sh
# check-gcc.sh by AKuHAK

 ## Check for libmpfr-dev
 ldconfig -p | grep libmpfr-dev 1> /dev/null || { echo "ERROR: Install libmpfr-dev before continuing."; exit 1; }

#!/bin/sh
# check-gcc.sh by AKuHAK

 ## Check for g++.
 g++ --version 1> /dev/null || { echo "ERROR: Install gcc before continuing."; exit 1; }

#!/bin/sh
# check-g++.sh by AKuHAK

 ## Check for g++.
 g++ --version 1> /dev/null || { echo "ERROR: Install g++ before continuing."; exit 1; }

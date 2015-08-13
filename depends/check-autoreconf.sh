#!/bin/sh
# check-autoreconf.sh by uyjulian

 ## Check for autoreconf.
 autoreconf --version 1> /dev/null || { echo "ERROR: Install autoreconf before continuing."; exit 1; }

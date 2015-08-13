#!/bin/sh
# check-autoconf2.64.sh by uyjulian

 ## Check for autoconf2.64.
 autoconf2.64 --version 1> /dev/null || { echo "ERROR: Install autoconf2.64 before continuing."; exit 1; }

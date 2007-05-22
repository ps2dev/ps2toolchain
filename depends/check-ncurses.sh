#!/bin/sh
# check-ncurses.sh by Dan Peori (danpeori@oopo.net)

 ## Check for a ncurses library.
 ls /usr/lib/libncurses.* 1> /dev/null || { echo "ERROR: Install ncurses before continuing."; exit 1; }

#!/bin/bash
# ps2client.sh by Naomi Peori (naomi@peori.ca)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

## Download the source code.
if test ! -d "ps2client/.git"; then
	git clone https://github.com/ps2dev/ps2client && cd ps2client || { exit 1; }
else
	cd ps2client && git pull && git fetch origin || { exit 1; }
fi

# We reset to the concrete tag
git reset --hard v1.0  || { exit 1; }

## Build and install.
make --quiet clean && make --quiet && make --quiet install && make --quiet clean || { exit 1; }

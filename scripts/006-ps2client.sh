#!/bin/sh

 cd ps2client

 ## Build and install.
 make -j8 && make install -j8 || { exit 1; }

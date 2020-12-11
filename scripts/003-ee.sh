#!/bin/bash
# 003-ee.sh by Francisco Javier Trujillo Mata (fjtrujy@gmail.com)

## Download the source code.
REPO_URL="https://github.com/fjtrujy/ps2toolchain-ee"
REPO_FOLDER="ps2toolchain-ee"
BRANCH_NAME="main"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || exit 1
fi

## Build and install
./toolchain.sh

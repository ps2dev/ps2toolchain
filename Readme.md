ps2toolchain
============

ps2toolchain is a collection of scripts and patches to allow you to build a toolchain to build PlayStation® 2 homebrew easily.

What these scripts do
=====================

These scripts download (with wget) and install [binutils 2.25](http://www.gnu.org/software/binutils/ "binutils") (ee/iop), [gcc 4.9.2](https://gcc.gnu.org/ "gcc") (ee/iop), [newlib 2.2.0](https://sourceware.org/newlib/ "newlib") (ee), [ps2sdk](https://github.com/ps2dev/ps2sdk "ps2sdk"), and [ps2client](https://github.com/ps2dev/ps2client "ps2client").

Requirements
============

1. Install gcc/clang, make, patch, git, and wget if you don't have those.

2. Add this to your login script (example: ~/.bash_profile)  
`export PS2DEV=/usr/local/ps2dev`  
`export PS2SDK=$PS2DEV/ps2sdk`  
`export PATH=$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin`  

3. Run toolchain.sh  
`./toolchain.sh`

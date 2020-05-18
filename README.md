![CI](https://github.com/ps2dev/ps2toolchain/workflows/CI/badge.svg)
![CI-Docker](https://github.com/ps2dev/ps2toolchain/workflows/CI-Docker/badge.svg)

# ps2toolchain

This program will automatically build and install the compiler tools used in the creation of homebrew software for the Sony PlayStation® 2 videogame system.

## **ATENTION!**

If you're trying to install in your machine the **WHOLE PS2 Development Environment** this is **NOT** the repo to use, you should use instead the [ps2dev](https://github.com/ps2dev/ps2dev "ps2dev") repo.

## What these scripts do

These scripts download (with wget) and install [binutils 2.14](http://www.gnu.org/software/binutils/ "binutils") (ee/iop), [gcc 3.2.3](https://gcc.gnu.org/ "gcc") (ee/iop), [newlib 1.10.0](https://sourceware.org/newlib/ "newlib") (ee).

## Requirements

1. Install gcc/clang, make, patch, git, texinfo and wget if you don't have those.

2. Add this to your login script (example: ~/.bash_profile)  
`export PS2DEV=/usr/local/ps2dev`  
`export PS2SDK=$PS2DEV/ps2sdk`  
`export PATH=$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin`  

3. Run toolchain.sh  
`./toolchain.sh`

![CI](https://github.com/ps2dev/ps2toolchain/workflows/CI/badge.svg)
![CI-Docker](https://github.com/ps2dev/ps2toolchain/workflows/CI-Docker/badge.svg)

# ps2toolchain

## **ATTENTION**

If you are confused on how to start developing for PS2, see the
[getting started](https://ps2dev.github.io/#getting-started) section on
the ps2dev main page.  

## Introduction

This program will automatically build and install the compiler tools used in the creation of homebrew software for the Sony PlayStation® 2 videogame system.

## What these scripts do

These scripts download (with `git clone`) and install:

-   [binutils 2.14](http://www.gnu.org/software/binutils/ "binutils") (iop, dvp)
-   [binutils 2.35.1](http://www.gnu.org/software/binutils/ "binutils") (ee),
-   [gcc 3.2.3](https://gcc.gnu.org/ "gcc") (iop)
-   [gcc 10.2.0](https://gcc.gnu.org/ "gcc") (ee)
-   [newlib 4.0.0](https://sourceware.org/newlib/ "newlib") (ee)

## Requirements

1.  Install gcc/clang, make, patch, git, texinfo, flex, bison, gsl, gmp, mpfr, mpc and gettext if you don't have those packages.
2.  Ensure that you have enough permissions for managing PS2DEV location (which defaults to `/usr/local/ps2dev`). PS2DEV location MUST NOT have spaces or special characters in it's path! For example, on Linux systems, you can set access for current user by running commands:
```bash
export PS2DEV=/usr/local/ps2dev
sudo mkdir -p $PS2DEV
sudo chown -R $USER: $PS2DEV
```
3.  Add this to your login script (example: `~/.bash_profile`)
```bash
export PS2DEV=/usr/local/ps2dev
export PS2SDK=$PS2DEV/ps2sdk
export PATH=$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin
```
4.  Run toolchain.sh
    `./toolchain.sh`

## Community

Links for discussion and chat are available
[here](https://ps2dev.github.io/#community).  


  ====================
   ABOUT THIS PROJECT
  ====================

   This project is designed to make it easy to set up a new PS2 toolchain
   from source. It originally started as an easy to read tutorial but grew
   into a useful tool for what was once an arcane and difficult procedure.

   The main part is the script, toolchain.sh, is designed to automatically
   grab the source and compile for you. It runs fine in any reasonably
   unix-like environment and has been tested fairly well under linux, bsd,
   osx and cygwin.

   Also included are reasonably up-to-date patches for binutils, gcc and
   newlib. The latest versions of these can be found in the official ps2dev
   cvs repository. Unless you're running into an odd bug you really should
   be ok with these patches.

  ==================
   HOW DO I USE IT?
  ==================

   Basically, you run the toolchain script:

    ## Make the script executable.
    chmod a+x ./toolchain.sh

    ## Run the script.
    ./toolchain.sh

   First, this script will attempt to make sure you have all the programs
   you need to build the toolchain. Then it will download the source from
   various places on the internet. Finally, it will compile and build the
   source. This may take a long time.

   Once finished, you need to add the following to your login settings:

    ## PS2DEV SETTINGS
    export PS2DEV="/usr/local/ps2dev"
    export PS2SDK="$PS2DEV/ps2sdk"
    export CVSROOT=":pserver:anonymous@cvs.ps2dev.org:/home/ps2cvs"
    export PATH="$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin"

   Then you're done!

  ===================
   ABOUT THE PATCHES
  ===================

   Here's a brief changelog that I've kept. It probably belongs in the
   actual patches themselves and will end up there eventually...

   binutils-2.14-PS2-20041127.patch:
    pixel: 20040214 (gruntwork) patch
    mrbrown: 20040307 patch
    ryani: 20040214 patch
    blackd: vu opcode 'w' target fix
    blackd: 'scei' name fix
    blackd: 'mfpc' T5 fix
    pixel/cody56: fix for irx files
    emoon/pixel/mrbrown: mips-opc.c mfpc fix

   gcc-3.2.2-PS2-20041130.patch:
    pixel: 20040214 (gruntwork) patch
    mrbrown: 20040222 patch
    blackd: 'scei' name fix patch
    pixel: fixed alignment bug
    ooPo: bash-3.0 'trap - 0' configure bug

   newlib-1.10.0-PS2-20040312.patch:
    ps2lib 2.0: patches for fileio
    ooPo: bash-3.0 'trap - 0' configure bug

  =============
   THE CREDITS
  =============

   Add yourself here, or be anonymous:

   Dan Peori (peori@oopo.net) - Created the script, patch maintenance.

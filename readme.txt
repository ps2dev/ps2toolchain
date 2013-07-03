
 ==================
 What does this do?
 ==================

  This program will automatically build and install a compiler and other
  tools used in the creation of homebrew software for the Sony Playstation 2
  videogame system.
  The scripts use GCC 4.9 from subversion.

 ================
 How do I use it?
 ================

 1) Set up your environment by installing the following software:

  gcc, make, patch, subversion, wget, git,
  automake, autoconf, gzip, tar,
  libmpfr-dev, libgmp3-dev

 2) Add the following to your login script:

  export PS2DEV=/usr/local/ps2dev
  export EE_TOOL_PREFIX="ee-"
  export EE_PREFIX="${EE_TOOL_PREFIX}"
  export IOP_TOOL_PREFIX="iop-"
  export IOP_PREFIX="${IOP_TOOL_PREFIX}"
  export PS2SDK="$PS2DEV/ps2sdk"
  export PATH="$PATH:$PS2DEV/ee/bin"
  export PATH="$PATH:$PS2DEV/iop/bin"
  export PATH="$PATH:$PS2DEV/dvp/bin"
  export PATH="${PS2DEV}/ps2sdk/bin:$PATH"
  export PATH="${PS2DEV}/bin:$PATH"

 3) Run the toolchain script:

  ./toolchain.sh

 ========================
 Where do I go from here?
 ========================

  Visit the following sites to learn more:

   http://www.ps2dev.org
   http://forums.ps2dev.org
   http://psx-scene.com/forums/ps2-homebrew-dev-emu-scene/

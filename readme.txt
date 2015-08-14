
 ==================
 What does this do?
 ==================

  This program will automatically build and install a compiler and other
  tools used in the creation of homebrew software for the Sony Playstation 2
  videogame system.

 ================
 How do I use it?
 ================

 1) Set up your environment by installing the following software:

  gcc, make, patch, subversion, wget

 2) Add the following to your login script:

  export PS2DEV=/usr/local/ps2dev
  export PATH=$PATH:$PS2DEV/bin
  export PATH=$PATH:$PS2DEV/ee/bin
  export PATH=$PATH:$PS2DEV/iop/bin
  export PATH=$PATH:$PS2DEV/dvp/bin
  export PS2SDK=$PS2DEV/ps2sdk
  export PATH=$PATH:$PS2SDK/bin

 3) Run the toolchain script:

  ./toolchain.sh

 ========================
 Where do I go from here?
 ========================

  Visit the following sites to learn more:

   http://www.ps2dev.org
   http://forums.ps2dev.org

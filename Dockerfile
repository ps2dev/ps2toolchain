FROM ubuntu:latest

LABEL authors="akuhak@gmail.com"

ENV PS2DEV /usr/local/ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV PATH   $PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin

COPY . /toolchain

RUN apt-get update &&\
  apt-get install -yqqq make bash gawk wget git make patch wget && \
  apt-get install -yqqq gcc && \
  cd /toolchain && \
  ./toolchain.sh 1 && \
  ./toolchain.sh 2 && \
  ./toolchain.sh 3 && \
  ./toolchain.sh 4 && \
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf \
    /toolchain/build/* \
    /tmp/*

WORKDIR /src

FROM ubuntu:12.04

LABEL authors="mathias.lafeldt@gmail.com, akuhak@gmail.com"

ENV PS2DEV /ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV PATH   $PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin

ENV TOOLCHAIN_VERSION master

ENV DEBIAN_FRONTEND noninteractive

COPY . /toolchain

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        autoconf \
        bzip2 \
        gcc \
        git \
        libucl-dev \
        make \
        patch \
        vim \
        wget \
        zip \
        zlib1g-dev \
    && cd /toolchain \
    && git checkout -qf $TOOLCHAIN_VERSION \
    && ./toolchain.sh 1 \
    && ./toolchain.sh 2 \
    && ./toolchain.sh 3 \
    && ./toolchain.sh 4 \
    && rm -rf \
        /ps2dev/test.tmp \
        /toolchain \
        /var/lib/apt/lists/*

WORKDIR /src
CMD ["/bin/bash"]

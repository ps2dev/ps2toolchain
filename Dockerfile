FROM ubuntu:12.04

ENV TOOLCHAIN_VERSION master

ENV PS2DEV /ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV PATH   $PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin

ENV DEBIAN_FRONTEND noninteractive

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
    && git clone git://github.com/ps2dev/ps2toolchain.git -b $TOOLCHAIN_VERSION /toolchain \
    && cd /toolchain \
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

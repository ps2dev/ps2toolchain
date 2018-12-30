FROM alpine:latest

LABEL authors="Maximus32, akuhak@gmail.com"

ENV PS2DEV /usr/local/ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV PATH   $PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin

COPY . /toolchain

RUN \
  apk add make bash gawk wget git make patch && \
  apk add --no-cache --virtual .build-deps gcc musl-dev && \
  cd /toolchain && \
  ./toolchain.sh 1 && \
  ./toolchain.sh 2 && \
  ./toolchain.sh 3 && \
  ./toolchain.sh 4 && \
  apk del .build-deps && \
  rm -rf \
    /toolchain/build/* \
    /tmp/*

WORKDIR /src

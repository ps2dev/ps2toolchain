# dvp stage of Dockerfile
FROM fjtrujy/ps2toolchain-dvp:latest

# iop stage of Dockerfile
FROM fjtrujy/ps2toolchain-iop:latest

# ee stage of Dockerfile
FROM fjtrujy/ps2toolchain-ee:latest

# Second stage of Dockerfile
FROM alpine:latest  

ENV PS2DEV /usr/local/ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV PATH $PATH:${PS2DEV}/bin:${PS2DEV}/ee/bin:${PS2DEV}/iop/bin:${PS2DEV}/dvp/bin:${PS2SDK}/bin

COPY --from=0 ${PS2DEV} ${PS2DEV}
COPY --from=1 ${PS2DEV} ${PS2DEV}
COPY --from=2 ${PS2DEV} ${PS2DEV}

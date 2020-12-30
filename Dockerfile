# ARGS for defining tags
ARG  BASE_DOCKER_DVP_IMAGE
ARG  BASE_DOCKER_IOP_IMAGE
ARG  BASE_DOCKER_EE_IMAGE

# dvp stage of Dockerfile
FROM $BASE_DOCKER_DVP_IMAGE

# iop stage of Dockerfile
FROM $BASE_DOCKER_IOP_IMAGE

# ee stage of Dockerfile
FROM $BASE_DOCKER_EE_IMAGE

# Second stage of Dockerfile
FROM alpine:latest  

ENV PS2DEV /usr/local/ps2dev
ENV PS2SDK $PS2DEV/ps2sdk
ENV PATH $PATH:${PS2DEV}/bin:${PS2DEV}/ee/bin:${PS2DEV}/iop/bin:${PS2DEV}/dvp/bin:${PS2SDK}/bin

COPY --from=0 ${PS2DEV} ${PS2DEV}
COPY --from=1 ${PS2DEV} ${PS2DEV}
COPY --from=2 ${PS2DEV} ${PS2DEV}
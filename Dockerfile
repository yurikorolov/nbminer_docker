ARG NVIDIA_CUDA_VERSION=11.6.2
ARG NVIDIA_CUDA_BASE_IMAGE=base-ubuntu20.04
ARG NVIDIA_CUDA_IMAGE_TAG=${NVIDIA_CUDA_VERSION}-${NVIDIA_CUDA_BASE_IMAGE}
FROM nvidia/cuda:$NVIDIA_CUDA_IMAGE_TAG

MAINTAINER YuriKorolov


# arg variables
ARG NBMINER_VERSION=42.0
ARG NBMINER_TAR_FILE=NBMiner_${NBMINER_VERSION}_Linux.tgz

# env variables
ENV ALGO=kawpow
ENV SERVER=stratum+tcp://rvn.2miners.com:6060
ENV USERNAME=RSVSQpK3QDgF3QVc5Q1togocAqD3Zy9FsB
ENV PASSWORD=x
ENV WORKER_NAME=nbminer
ENV API_URL=0.0.0.0
ENV API_PORT=8000

WORKDIR /
# package and dependency setup
RUN apt update -y && DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y wget && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && wget https://github.com/NebuTech/NBMiner/releases/download/v$NBMINER_VERSION/$NBMINER_TAR_FILE \
    && tar -zxvf $NBMINER_TAR_FILE \
    && cd NBMiner_Linux \
    && chmod +x nbminer \
    && mv nbminer /usr/local/bin \
    && cd ../ \
    && rm $NBMINER_TAR_FILE
    
# cleanup
RUN apt -y remove wget \
    && apt -y autoremove

# workaround for lib link
RUN ln -s /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so

# env setup
ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
ENTRYPOINT /entrypoint.sh

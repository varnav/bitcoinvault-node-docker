#FROM ubuntu:20.04 as builder
FROM gcc:10

LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>"
LABEL Description="Docker image for Bitcoin Vault node"
LABEL License="MIT License"

ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-ex", "-c"]

RUN apt-get update \
    && apt-get install --no-install-recommends -y apt-utils curl sudo ca-certificates \
    && apt-get install --no-install-recommends -y dirmngr gosu gpg sudo lsof build-essential cmake clang openssl libssl-dev wget git libtool autotools-dev automake pkg-config bsdmainutils python3 libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libzmq3-dev libqrencode-dev \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/
RUN git clone --depth 1 --recursive https://github.com/bitcoinvault/bitcoinvault.git
WORKDIR /usr/src/bitcoinvault
RUN ./autogen.sh \
&& ./configure --disable-wallet --without-gui \
&& make \
&& make install
WORKDIR /
COPY entrypoint.sh .

RUN groupadd --gid "$HOST_USER_GID" bvault \
    && useradd --uid "$HOST_USER_UID" --gid "$HOST_USER_GID" --create-home --shell /bin/bash bvault \
    && mkdir /opt/bvault \
	&& chown -R bvault:bvault "/opt/bvault" \
	&& ln -sfn /opt/bvault /home/bvault/.bvault \
	&& chown -h bvault:bvault /home/bvault/.bvault \
	&& chmod +x /entrypoint.sh

VOLUME /opt/bvault

USER bvault
EXPOSE 8332 8333 18332 18333

ENTRYPOINT ["./entrypoint.sh"]

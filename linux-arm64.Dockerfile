FROM hotio/base@sha256:a9e293e917c4bbffca77790227911161532e7d8acb1e023249a45af883f2bfbd

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        python && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# https://github.com/nzbget/nzbget/releases
ARG NZBGET_VERSION=21.0

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

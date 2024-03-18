ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 6789
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="6789/tcp,6789/udp"

RUN apk add --no-cache py3-lxml

ARG VERSION
RUN runfile="/tmp/app.run" && \
    mkdir "${APP_DIR}/bin" && \
    curl -fsSL -o "${runfile}" "https://github.com/nzbgetcom/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && \
    sh "${runfile}" --destdir "${APP_DIR}/bin" && \
    rm "${runfile}" && \
    rm -rf "${APP_DIR}/bin/unrar" "${APP_DIR}/bin/7za" && \
    ln -s /usr/bin/unrar "${APP_DIR}/bin/unrar" && \
    ln -s /usr/bin/7z "${APP_DIR}/bin/7za" && \
    chmod -R u=rwX,go=rX "${APP_DIR}/bin" && \
    chown -R root:root "${APP_DIR}/bin"

COPY root/ /

RUN chmod 755 "${APP_DIR}/bin/scripts/"*

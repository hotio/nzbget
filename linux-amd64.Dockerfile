ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}
EXPOSE 6789
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="6789/tcp,6789/udp"

RUN apk add --no-cache py3-lxml

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && \
    curl -fsSL -o "${runfile}" "https://github.com/nzbgetcom/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && \
    sh "${runfile}" --destdir "${APP_DIR}" && \
    rm "${runfile}" && \
    rm -rf "${APP_DIR}/unrar" "${APP_DIR}/7za" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R root:root "${APP_DIR}"

COPY root/ /

RUN chmod 755 "${APP_DIR}/scripts/"*

FROM ghcr.io/hotio/base@sha256:a137f6d930ea033c4ae938d27c5a5da5da3f940a5b3cfdac5579985e03f41d63

EXPOSE 6789

RUN apk add --no-cache python3 py3-lxml openssl

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    curl -fsSL -o "/app/cacert.pem" "https://curl.se/ca/cacert.pem" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R root:root "${APP_DIR}"

COPY root/ /
RUN chmod 755 "${APP_DIR}/scripts/"*

FROM cr.hotio.dev/hotio/base@sha256:28bb946f53b50b204e0c14ea79daf2eed22b096a4cbc969d13710e9e66be7a3e

EXPOSE 6789

RUN apk add --no-cache python3 py3-lxml

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    curl -fsSL "https://curl.se/ca/cacert.pem" | sed '/^DST Root CA X3$/,/^-----END CERTIFICATE-----$/d;' > "${APP_DIR}/cacert.pem" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R root:root "${APP_DIR}"

COPY root/ /
RUN chmod 755 "${APP_DIR}/scripts/"*

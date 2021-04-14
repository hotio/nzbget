FROM hotio/base@sha256:6fa9179cf9aa06dd0d03645fb5920bf2fa7edf73e3505f34b59ecfcf7340a2c6

EXPOSE 6789

RUN apk add --no-cache python3 py3-lxml

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R root:root "${APP_DIR}"

COPY root/ /
RUN chmod 755 "${APP_DIR}/scripts/"*

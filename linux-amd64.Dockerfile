FROM hotio/base@sha256:7f7cae79a19448a4b2ecbef82eb6d7df34b63daff3494891135cea6dbeb47220

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

# https://github.com/nzbget/nzbget/releases
ARG NZBGET_VERSION=21.0

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

FROM hotio/base@sha256:16e7a6ff1afb079c94230d0994892eb40721f9673c4adb914d3cc26f97eda18f

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

# https://github.com/nzbget/nzbget/releases
ARG NZBGET_VERSION=21.0

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

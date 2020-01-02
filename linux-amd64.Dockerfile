FROM hotio/base@sha256:8c586aa889b75f25500c52880bb25396c15af009894477d838bb5c0d7ea6a2aa

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

# https://github.com/nzbget/nzbget/releases
ARG NZBGET_VERSION=21.0

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

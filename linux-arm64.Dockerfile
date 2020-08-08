FROM hotio/base@sha256:c0d26bf85d89f03b93cdb5d0882e4f1573ca1a30d9f6d059c1ad06ccb568c6a9

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG NZBGET_VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

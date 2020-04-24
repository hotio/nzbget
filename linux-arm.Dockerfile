FROM hotio/base@sha256:79a94a7ab0c1945b638c37c9b531c54652ce87a738e4c6a0db7cf9b9c7692023

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

ARG NZBGET_VERSION
ARG NZBGET_VERSION_SHORT

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION_SHORT}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

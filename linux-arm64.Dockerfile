FROM hotio/base@sha256:ff26d5500ebd62dc05753c82319d7f9c12577986a4d498800717f8fb82899c5a

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

ARG NZBGET_VERSION
ARG NZBGET_VERSION_SHORT

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION_SHORT}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

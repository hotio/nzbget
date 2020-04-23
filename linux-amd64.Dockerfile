FROM hotio/base@sha256:e6394cccaed4697611ed6ea31900aa3383f45fea45fba21a9b927966a7fb43d9

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

ARG NZBGET_VERSION
ARG NZBGET_VERSION_SHORT

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION_SHORT}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

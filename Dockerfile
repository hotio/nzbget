FROM hotio/base

ARG DEBIAN_FRONTEND="noninteractive"

ENV APP="NZBGet"
EXPOSE 6789
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:6789 || exit 1

# install app
# https://github.com/nzbget/nzbget/releases
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v20.0/nzbget-20.0-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /


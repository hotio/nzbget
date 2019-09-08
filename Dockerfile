FROM hotio/base

ARG DEBIAN_FRONTEND="noninteractive"
ARG GIT_COMMIT
ARG GIT_TAG
ARG ARCH

ENV GIT_COMMIT="${GIT_COMMIT}" GIT_TAG="${GIT_TAG}" ARCH="${ARCH}"
ENV APP="NZBGet"
EXPOSE 6789
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:6789 || exit 1

# install app
# https://github.com/nzbget/nzbget/releases
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v21.0/nzbget-21.0-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

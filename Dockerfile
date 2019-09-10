FROM hotio/base

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:6789 || exit 1

# install app
# https://github.com/nzbget/nzbget/releases
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v21.0/nzbget-21.0-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

ARG COMMIT
ARG TAG
ARG APP

ENV COMMIT="${COMMIT}" TAG="${TAG}" APP="${APP}"

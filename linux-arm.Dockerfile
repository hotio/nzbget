FROM hotio/base@sha256:21ab5118292e7050b8c9a5ad805a6510bb7268442b14b4914e5a44f95f341481

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

# https://github.com/nzbget/nzbget/releases
ARG NZBGET_VERSION=21.1-testing-r2311
ARG NZBGET_VERSION_SHORT=21.1-r2311

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION_SHORT}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

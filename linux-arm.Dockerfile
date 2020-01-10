FROM hotio/base@sha256:ef43d87e8de045f3d6f4f4a8d38ede7ff1151992844227d0d0ed04c70b077852

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

ARG NZBGET_VERSION=21.1-testing-r2311
ARG NZBGET_VERSION_SHORT=21.1-r2311

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION_SHORT}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

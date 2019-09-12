FROM hotio/base

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:6789 || exit 1

COPY root/ /

# install app
RUN version=$(sed -n '1p' /versions/nzbget) && \
    runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${version}/nzbget-${version}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

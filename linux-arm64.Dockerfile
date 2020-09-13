FROM hotio/base@sha256:862937c0d795328dea8b83d5ee04a9aa82e729adb939e84f8b79f8123800cea5

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG VERSION
ARG VERSION_SHORT
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION_SHORT}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

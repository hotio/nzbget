FROM hotio/base@sha256:6388363381be9eb6f9b4215ee0ffedcac3a573f0daed54193219fc0c2ffb873d

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG NZBGET_VERSION
ARG NZBGET_VERSION_SHORT
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION_SHORT}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

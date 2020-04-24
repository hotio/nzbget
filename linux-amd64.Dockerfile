FROM hotio/base@sha256:72bbe97412e4116582faeaefa19565116388cf9f60c21cf4b513cb72beb942b8

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6789

ARG NZBGET_VERSION
ARG NZBGET_VERSION_SHORT

# install app
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION_SHORT}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

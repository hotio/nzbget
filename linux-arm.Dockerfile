FROM hotio/base@sha256:4e4d9fc97ed14e8c66adef921f3b55186be80856d8d427fbda5fb447d700e226

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG NZBGET_VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

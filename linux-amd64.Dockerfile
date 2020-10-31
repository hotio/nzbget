FROM hotio/base@sha256:d1223a83f726d54dfb17b5757f8ac65f3d0f884c132b48667265a9f5e022e871

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

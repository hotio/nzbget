FROM hotio/base@sha256:faf26d226b8166352c02269ba37e1032845b9cb6d2f13847c759d0f29a46fc35

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

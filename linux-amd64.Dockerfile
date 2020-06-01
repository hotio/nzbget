FROM hotio/base@sha256:45d6eab61b2b710a6634dc8f5257567b60e9525841439fc493c1a629f6102be5

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG NZBGET_VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

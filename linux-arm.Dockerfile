FROM hotio/base@sha256:446dc3af8d33da7fb194ac1a5170f27c76fefa89067023a1cab73463edb925d8

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG NZBGET_VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${NZBGET_VERSION}/nzbget-${NZBGET_VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

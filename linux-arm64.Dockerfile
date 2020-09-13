FROM hotio/base@sha256:12a997c30659bf971cda4b0225148f7cdd149f5d14992f65471a92dab1c8eed4

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

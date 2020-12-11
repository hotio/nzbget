FROM hotio/base@sha256:42068ebaa6321d33a4e182cb66c8b40d87027a0936afbdff3ed4d85f315cc77a

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

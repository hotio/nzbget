FROM hotio/base@sha256:919a5fd851bcbefbe652b8ced0a4fdf8173ba8a58039e1fac0d4256225454086

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG VERSION
ARG VERSION_SHORT
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION_SHORT}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

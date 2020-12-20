FROM hotio/base@sha256:20fdc5b0e7a27d1fa0ba18891dcca79c2d2f25d7a45bde88fff625c63942b2e3

EXPOSE 6789

RUN apk add --no-cache python3

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

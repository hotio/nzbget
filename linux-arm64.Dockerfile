FROM hotio/base@sha256:5f68a5ce9c8a2ebbcb8bab7c5d2953f1e6ac41784fad32b57652f36acd9a0ee2

EXPOSE 6789

RUN apk add --no-cache python3 py3-lxml

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R root:root "${APP_DIR}"

COPY root/ /
RUN chmod 755 "${APP_DIR}/scripts/"*

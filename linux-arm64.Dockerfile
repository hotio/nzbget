ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}

EXPOSE 6789

RUN apk add --no-cache python3 py3-lxml

# install app
ARG VERSION
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    curl -fsSL "https://curl.se/ca/cacert.pem" | sed '/^DST Root CA X3$/,/^-----END CERTIFICATE-----$/d;' > "${APP_DIR}/cacert.pem" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R root:root "${APP_DIR}"

COPY root/ /
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/

RUN chmod 755 "${APP_DIR}/scripts/"*

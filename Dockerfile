ARG BUILD_FROM
FROM $BUILD_FROM

ARG \
    BUILD_ARCH \
    YQ_VERSION

RUN \
    set -x \
    && apk add --no-cache \
        git \
        docker \
        docker-cli-buildx \
        coreutils \
    \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then \
        wget -q -O /usr/bin/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64"; \
    else \
        exit 1; \
    fi \
    && chmod +x /usr/bin/yq

COPY builder.sh /usr/bin/

WORKDIR /data
ENTRYPOINT ["/usr/bin/builder.sh"]

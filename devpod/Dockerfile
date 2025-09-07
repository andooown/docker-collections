FROM debian:stable-slim

ARG TARGETARCH

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
RUN case "${TARGETARCH}" in \
      amd64) DEVPOD_ARCH="devpod-linux-amd64" ;; \
      arm64) DEVPOD_ARCH="devpod-linux-arm64" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/${DEVPOD_ARCH}" && \
    chmod +x devpod && \
    mv devpod /usr/local/bin/

ENTRYPOINT ["devpod"]

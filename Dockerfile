ARG CONFIG_SERVER_VERSION=2.0.2
ARG REGISTRY=harbor.honeur.org
ARG REPOSITORY=honeur

FROM golang:1.16-buster as golang-build

WORKDIR /go/src/app
COPY cmd cmd

RUN go env -w GO111MODULE=auto; \
    go install -v ./...

FROM $REGISTRY/$REPOSITORY/config-server-base:$CONFIG_SERVER_VERSION

COPY --from=golang-build /go/bin/healthcheck /app/healthcheck
HEALTHCHECK --start-period=1m30s --interval=1m --timeout=10s --retries=10 CMD ["/app/healthcheck"]

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --system --gid 54321 feder8;\
    useradd --system --create-home --home-dir /home/feder8 --shell /bin/bash --uid 54321 --gid 54321 feder8

USER feder8

RUN mkdir -p /home/feder8/config-repo

VOLUME /home/feder8/config-repo

EXPOSE 8080
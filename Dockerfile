FROM feder8/config-server

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        curl \
    ; \
    rm -rf /var/lib/apt/lists/*

USER nobody:nogroup

HEALTHCHECK --start-period=1m30s --interval=1m --timeout=10s --retries=10 CMD curl --fail -s http://localhost:8080/actuator/health/liveness || exit 1

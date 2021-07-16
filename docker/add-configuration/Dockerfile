FROM python:3.8-slim-buster

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    pip install sh

RUN groupadd --system --gid 54321 feder8; \
    useradd --system --create-home --home-dir /home/feder8 --shell /bin/bash --uid 54321 --gid 54321 feder8

USER feder8

WORKDIR /home/feder8

RUN mkdir -p config-repo; \
    git config --global user.email "feder8@feder8-platform.org"; \
    git config --global user.name "feder8"

COPY ./setup-scripts .
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["run-script"]

VOLUME [ "/home/feder8/config-repo" ]
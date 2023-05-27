FROM qmcgaw/godevcontainer:debian

RUN apt update && apt install -y gnupg curl git

RUN wget https://github.com/tinygo-org/tinygo/releases/download/v0.27.0/tinygo_0.27.0_amd64.deb \
    && apt install -y ./tinygo_0.27.0_amd64.deb \
    && rm tinygo_0.27.0_amd64.deb

RUN curl https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | apt-key add - \
    && echo "deb https://us-central1-apt.pkg.dev/projects/rp-byoc-tyler wasm-feature-branch-apt main" | tee -a /etc/apt/sources.list.d/artifact-registry.list \
    && apt update \
    && apt install redpanda

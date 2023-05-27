FROM qmcgaw/godevcontainer

RUN wget https://github.com/tinygo-org/tinygo/releases/download/v0.27.0/tinygo_0.27.0_amd64.deb \
    && sudo dpkg -i -y tinygo_0.27.0_amd64.deb \
    && rm tinygo_0.27.0_amd64.deb

RUN curl https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | sudo apt-key add - \
    && echo "deb https://us-central1-apt.pkg.dev/projects/rp-byoc-tyler wasm-feature-branch-apt main" | sudo tee -a /etc/apt/sources.list.d/artifact-registry.list \
    && sudo apt update \
    && sudo apt install redpanda

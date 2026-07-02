
sudo apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    bash \
    file \
    unzip \
    xz-utils \
    \
    build-essential \
    make \
    pkg-config \
    cmake \
    ninja-build \
    \
    clang \
    lld \
    llvm \
    libclang-dev \
    \
    protobuf-compiler \
    \
    libssl-dev \
    zlib1g-dev \
    libsqlite3-dev \
    libpq-dev \
    \
    && rm -rf /var/lib/apt/lists/*

mkdir -p /opt/rust/cargo /opt/rust/rustup /workspace \
    && chmod -R a+rX /opt/rust \
    && chmod 1777 /workspace

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup-init.sh \
    && CARGO_HOME=/opt/rust/cargo \
       RUSTUP_HOME=/opt/rust/rustup \
       sh /tmp/rustup-init.sh \
         -y \
         --no-modify-path \
         --profile default \
         --default-toolchain "${RUST_TOOLCHAIN}" \
    && rm /tmp/rustup-init.sh

CARGO_HOME=/opt/rust/cargo \
RUSTUP_HOME=/opt/rust/rustup \
rustup target add wasm32-unknown-unknown --toolchain "${RUST_TOOLCHAIN}" \
    && CARGO_HOME=/opt/rust/cargo \
       RUSTUP_HOME=/opt/rust/rustup \
       cargo install dioxus-cli --version "${DIOXUS_CLI_VERSION}" --locked \
    && chmod -R a+rX /opt/rust \
    && rustc --version \
    && cargo --version \
    && dx --version

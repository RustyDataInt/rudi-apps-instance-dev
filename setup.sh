#!/bin/bash
set -e

# Main script to set up the RuDI development environment.

# Read the configuration file
if [ ! -f "config.yml" ]; then
    echo "RuDI ERROR: 'config.yml' not found!"
    exit 1
fi
RUST_TOOLCHAIN=$(grep "RUST_TOOLCHAIN:" config.yml | awk '{print $2}' | tr -d '"')
DIOXUS_VERSION=$(grep "DIOXUS_VERSION:" config.yml | awk '{print $2}' | tr -d '"')

echo 
echo "RuDI SETUP: Setting up the RuDI development environment"
echo "Rust toolchain: $RUST_TOOLCHAIN"
echo "Dioxus version: $DIOXUS_VERSION"

# Install system dependencies
echo 
echo "RuDI SETUP: Installing system dependencies"
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    git \
    nano \
    tree \
    unzip \
    build-essential \
    pkg-config \
    cmake \
    clang \
    lld \
    llvm \
    libclang-dev \
    libssl-dev \
    libsqlite3-dev \
    libpq-dev \
    zlib1g-dev \
    protobuf-compiler

# Install Rust
echo 
echo "RuDI SETUP: Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    --default-toolchain "$RUST_TOOLCHAIN"
source "$HOME/.cargo/env"

# Install Dioxus
echo
echo "RuDI SETUP: Installing Dioxus"
rustup target add wasm32-unknown-unknown
curl -sSL https://dioxus.dev/install.sh -o /tmp/install-dioxus.sh
bash /tmp/install-dioxus.sh "v$DIOXUS_VERSION"
rm /tmp/install-dioxus.sh

# Record GitHub credentials for RuDI forked/private repos
if [ "$GITHUB_USER" != "" ] || [ "$GITHUB_PAT" != "" ]; then
    TOML_FILE="$HOME/gitCredentials.toml"
    echo "USER_NAME   = \"NA\""  > $TOML_FILE
    echo "USER_EMAIL  = \"NA\"" >> $TOML_FILE
    echo "GITHUB_USER = \"$GITHUB_USER\"" >> $TOML_FILE
    echo "GITHUB_PAT  = \"$GITHUB_PAT\""  >> $TOML_FILE
fi

# Install RuDI
echo
echo "RuDI SETUP: Installing RuDI"
cd "$HOME"
if [ ! -d "$HOME/rudi" ]; then
    git clone https://github.com/RustyDataInt/rudi.git
fi
cd "$HOME/rudi"
./install.sh
cd "$HOME"

# Update PATH for future sessions
echo
echo "RuDI SETUP: Updating PATH in ~/.bashrc"
if ! grep -q '.cargo/bin' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$HOME/.bashrc"
fi
echo 'export PATH="$HOME/rudi:$PATH"' >> "$HOME/.bashrc"

# Confirm installation
echo ""
echo "RuDI SETUP: Installed versions:"
rustc --version
cargo --version
dx --version

# Final messages
echo ""
echo "RuDI SETUP: RuDI development environment setup complete!"
echo ""
echo "RuDI SETUP: Run 'source ~/.bashrc' or log out/in to update PATH."

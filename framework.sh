#!/bin/bash
set -e

# Support script for RuDI team developers to compile rudi_apps.
echo 
echo "RuDI SETUP: Building rudi_apps"
DEV_DIR="$HOME/rudi/frameworks/developer-forks/rudi-apps-framework/rudi_apps"
if [ -d "$DEV_DIR" ]; then
    cd "$DEV_DIR"
else 
    cd "$HOME/rudi/frameworks/definitive/rudi-apps-framework/rudi_apps"
fi
cargo build

#!/bin/bash
set -e

# Support script to add and compile a RuDI tool suite for development.
TOOL_SUITE=$1
REPO=$(echo $TOOL_SUITE | cut -d'/' -f2)

echo 
echo "RuDI SETUP: Cloning $TOOL_SUITE"
rudi -d add --suite $TOOL_SUITE
rudi -d install --forks

echo 
echo "RuDI SETUP: Building $REPO"
DEV_DIR="$HOME/rudi/suites/developer-forks/$REPO/apps/dioxus/shared/server"
if [ -d "$DEV_DIR" ]; then
    cd "$DEV_DIR"
else 
    cd "$HOME/rudi/suites/definitive/$REPO/apps/dioxus/shared/server"
fi
rudi -d dx build --force-sequential

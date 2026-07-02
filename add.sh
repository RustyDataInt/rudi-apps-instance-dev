#!/bin/bash
set -e

# Support script to add and compile a RuDI tool suite for development.
TOOL_SUITE=$1
REPO=$(echo $TOOL_SUITE | cut -d'/' -f2)

echo 
echo "RuDI SETUP: Cloning $TOOL_SUITE"
rudi add --suite $TOOL_SUITE

echo 
echo "RuDI SETUP: Building $REPO"
# this could be a developer fork, installed into definitive for this instance
cd "$HOME/rudi/suites/definitive/$REPO/apps/dioxus/shared/server"
rudi dx build 

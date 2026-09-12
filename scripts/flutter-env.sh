#!/usr/bin/env zsh
# Source this file from the repository root to use the workspace-local SDK.
export PATH="${PWD}/.tools/flutter/bin:${PATH}"
export FLUTTER_SUPPRESS_ANALYTICS=true
export DART_SUPPRESS_ANALYTICS=true
export XDG_CONFIG_HOME="${PWD}/.tools/dart-config"
export PUB_CACHE="${PWD}/.tools/pub-cache"

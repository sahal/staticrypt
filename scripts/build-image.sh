#!/usr/bin/env bash

set -e
set -u

echo "PWD: $(pwd)"

npm install
npm pack
cp "$(find . -maxdepth 1 -type f -name "staticrypt*.tgz")" ./staticrypt.tgz

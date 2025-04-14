#!/usr/bin/env bash

set -e
set -u

STATICRYPT_PASSWORD=$(generate-passwords.sh)
export STATICRYPT_PASSWORD

echo "STATICRYPT_PASSWORD: $STATICRYPT_PASSWORD"

staticrypt ./app/input.html
cp ./encrypted/input.html ./app/output.html

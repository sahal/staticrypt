#!/usr/bin/env bash

set -e
set -u

STATICRYPT_PASSWORD="${STATICRYPT_PASSWORD:-unset}"

# allow override b/c password123 is probably secure enough.
if [[ "${STATICRYPT_PASSWORD:-unset}" == "unset" ]]; then
  STATICRYPT_PASSWORD=$(generate-passwords.sh)
fi

export STATICRYPT_PASSWORD

echo "STATICRYPT_PASSWORD: $STATICRYPT_PASSWORD"

staticrypt ./app/input.html
cp ./encrypted/input.html ./app/output.html

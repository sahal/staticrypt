#!/usr/bin/env bash

set -e
set -u
#set -x

# https://stackoverflow.com/a/29436423
yes_or_no() {
  while true; do
    read -r -p "$* [y/n]: " yn
    case $yn in
      [Yy]*) return 0  ;;
      [Nn]*) echo "Aborted" ; return  1 ;;
    esac
  done
}


if [[ ! -f "${TASK_FILE:-unset}" ]]; then
  echo "No regular file exists at $TASK_FILE; I QUIT!"
  echo "Set a TASK_FILE env var, please."
  exit 1
fi

if [[ "${PLAYDIR:-unset}" == "unset" ]]; then
  echo "No PLAYDIR env var set"
  echo "Using mktemp to generate one"
  PLAYDIR=$(mktemp --directory)
  export PLAYDIR
fi

mkdir -p "${PLAYDIR}"

echo PLAYDIR: "${PLAYDIR}"
echo TASK_FILE: "${TASK_FILE}"

cp "${TASK_FILE}" "${PLAYDIR}/input.html"
podman run  \
            -v "${PLAYDIR}":/home/node/app:rw  \
            -e PASSWORD_LENGTH=64 \
            -e PASSWORD_CHARSET=a-zA-Z0-9 \
            -e STATICRYPT_PASSWORD="${STATICRYPT_PASSWORD}" \
            staticrypt:latest

echo "Test out the file at output.html"
nohup firefox "${PLAYDIR}/output.html" >/dev/null

yes_or_no "Do you want me to continue to overwrite the original file?" || exit
mv "${PLAYDIR}/output.html" "${TASK_FILE}"

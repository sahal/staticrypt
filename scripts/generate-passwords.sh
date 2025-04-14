#! /usr/bin/env bash
# by Sahal Ansari - github@sahal.info
# based on this blog post by Kevin Goodman
# https://web.archive.org/web/20090203104553/blog.colovirt.com/2009/01/07/linux-generating-strong-passwords-using-randomurandom/
# NOW WITH MORE ENV VARS!

set -e
set -u

PASSWORD_LENGTH="${PASSWORD_LENGTH:-64}"
PASSWORD_COUNT=${PASSWORD_COUNT:-1}
#alpha-numeric-special chars
PASSWORD_CHARSET="${PASSWORD_CHARSET:-unset}"
#alpha-numeric
#PASSWORD_CHARSET="a-zA-Z0-9"

random_source="/dev/urandom"

# parameter expansion and default values don't work for this particular
# variable values
if [[ "${PASSWORD_CHARSET}" == "unset" ]]; then
  PASSWORD_CHARSET="a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=}"
fi

tr -dc "$PASSWORD_CHARSET" < "$random_source" | \
  fold -w "$PASSWORD_LENGTH" | \
  head -n "$PASSWORD_COUNT" | \
  grep -i '[!"$PASSWORD_CHARSET"]'

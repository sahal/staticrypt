#!/bin/sh -e
# by Sahal Ansari - github@sahal.info
# based on this blog post by Kevin Goodman
# http://blog.colovirt.com/2009/01/07/linux-generating-strong-passwords-using-randomurandom/
# NOTE: install haveged for faster/'better' results!

length="${1:-64}"
count=1

random_source="/dev/urandom"
#random_source="/dev/random"

#alpha-numeric-special chars
chars="a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?="
#alpha-numeric
#chars="a-zA-Z0-9"

cat "$random_source" | tr -dc "$chars" | fold -w "$length" | head -n "$count"| grep -i '[!"$chars"]'

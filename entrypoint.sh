#!/bin/bash
# shellcheck disable=SC2016

set -e

if [ "$1" = 'postfix' ]; then

  # postfix needs fresh copies of files in its chroot jail
  mkdir -p /var/spool/postfix/etc
  cp /etc/{hosts,localtime,nsswitch.conf,resolv.conf,services} /var/spool/postfix/etc/

  test -f /etc/aliases && postalias /etc/aliases || true
  test -f /etc/postfix/generic && postmap /etc/postfix/generic || true
  test -f /etc/postfix/virtual && postmap /etc/postfix/virtual || true

  exec "$@"
fi

exec "$@"

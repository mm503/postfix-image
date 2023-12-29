#!/bin/bash
# shellcheck disable=SC2016

set -e

if [ "$1" = 'postfix' ]; then

  # postfix needs fresh copies of files in its chroot jail
  cp /etc/{hosts,localtime,nsswitch.conf,resolv.conf,services} /var/spool/postfix/etc/

  postmap /etc/aliases
  postmap /etc/postfix/generic
  postmap /etc/postfix/virtual

  exec "$@"
fi

exec "$@"

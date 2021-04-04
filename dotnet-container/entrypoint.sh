#!/bin/sh
if [ -z "${AUTHORIZED_KEYS}" ]; then
  echo "Need your ssh public key as AUTHORIZED_KEYS env variable. Abnormal exit ..."
  exit 1
fi

echo "${AUTHORIZED_KEYS}" > ~/.ssh/authorized_keys
chmod 0400 ~/.ssh/authorized_keys

ssh-keygen -q -f ~/.ssh/ssh_host_dsa_key -t dsa -N ""
ssh-keygen -q -f ~/.ssh/ssh_host_rsa_key -t rsa -N ""
ssh-keygen -q -f ~/.ssh/ssh_host_ecdsa_key -t ecdsa -N ""
ssh-keygen -q -f ~/.ssh/ssh_host_ed25519_key -t ed25519 -N ""

exec "$@"

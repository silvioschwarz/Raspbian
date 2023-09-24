#! /bin/sh

sudo -i
cd /etc/wireguard
umask 077
name="client_name"
wg genkey | tee "${name}.key" | wg pubkey > "${name}.pub"

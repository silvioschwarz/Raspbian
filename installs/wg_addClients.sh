#! /bin/sh

cd /etc/wireguard
umask 077

echo "Enter Client Name:"
echo

read name
#name="client_name"
wg genkey | tee "${name}.key" | wg pubkey > "${name}.pub"


wg genpsk > "${name}.psk"

echo "[Peer]" >> /etc/wireguard/wg0.conf
echo "PublicKey = $(cat "${name}.pub")" >> /etc/wireguard/wg0.conf
echo "PresharedKey = $(cat "${name}.psk")" >> /etc/wireguard/wg0.conf
echo "AllowedIPs = 10.100.0.2/32, fd08:4711::2/128" >> /etc/wireguard/wg0.conf


#wg syncconf wg0 <(wg-quick strip wg0)

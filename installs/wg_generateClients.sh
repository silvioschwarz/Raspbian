#! /usr/bin/env bash
umask 077

ipv4="$1$4"
ipv6="$2$4"
serv4="${1}1"
serv6="${2}1"
target="$3"
name="$5"

wg genkey | tee "${name}.key" | wg pubkey > "${name}.pub"
wg genpsk > "${name}.psk"

echo "# $name" >> /etc/wireguard/wg0.conf
echo "[Peer]" >> /etc/wireguard/wg0.conf
echo "PublicKey = $(cat "${name}.pub")" >> /etc/wireguard/wg0.conf
echo "PresharedKey = $(cat "${name}.psk")" >> /etc/wireguard/wg0.conf
echo "AllowedIPs = $ipv4/32, $ipv6/128" >> /etc/wireguard/wg0.conf
echo "" >> /etc/wireguard/wg0.conf

echo "[Interface]" > "${name}.conf"
echo "Address = $ipv4/32, $ipv6/128" >> "${name}.conf"
echo "DNS = ${serv4}, ${serv6}" >> "${name}.conf" #Specifying DNS Server
echo "PrivateKey = $(cat "${name}.key")" >> "${name}.conf"
echo "" >> "${name}.conf"
echo "[Peer]" >> "${name}.conf"
echo "PublicKey = $(cat server.pub)" >> "${name}.conf"
echo "PresharedKey = $(cat "${name}.psk")" >> "${name}.conf"
echo "Endpoint = $target" >> "${name}.conf"
echo "AllowedIPs = ${serv4}/32, ${serv6}/128" >> "${name}.conf" # clients isolated from one another
# echo "AllowedIPs = ${1}0/24, ${2}/64" >> "${name}.conf" # clients can see each other
echo "PersistentKeepalive = 25" >> "${name}.conf"

sudo apt-get install qrencode

# Print QR code scanable by the Wireguard mobile app on screen
qrencode -t ansiutf8 < "${name}.conf"

wg syncconf wg0 <(wg-quick strip wg0)

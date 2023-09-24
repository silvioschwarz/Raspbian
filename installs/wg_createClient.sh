#! /bin/sh

echo "Enter Client Name:"
read name


echo "[Interface]" > "${name}.conf"
echo "Address = 10.100.0.2/32, fd08:4711::2/128" >> "${name}.conf" # May need editing
echo "DNS = 10.100.6.166" >> "${name}.conf"                          # Your Pi-hole's IP

echo "PrivateKey = $(cat "${name}.key")" >> "${name}.conf"


echo "[Peer]" >> "${name}.conf"
echo "AllowedIPs = 10.100.0.1/32, fd08:4711::1/128" >> "${name}.conf"
echo "Endpoint = vpn.silvioschwarz.xyz:47111" >> "${name}.conf"
echo "PersistentKeepalive = 25" >> "${name}.conf"


echo "PublicKey = $(cat server.pub)" >> "${name}.conf"
echo "PresharedKey = $(cat "${name}.psk")" >> "${name}.conf"
exit


sudo apt-get install qrencode
sudo qrencode -t ansiutf8 < "/etc/wireguard/${name}.conf"

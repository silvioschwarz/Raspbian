#! /bin/sh

sudo apt-get install wireguard wireguard-tools

cd /etc/wireguard
umask 077

wg genkey | tee server.key | wg pubkey > server.pub

FILE="/etc/wireguard/wg0.conf"

touch $FILE

echo "[Interface]" >> $FILE
echo "Address = 10.100.0.1/24, fd08:4711::1/64" >> $FILE
echo "ListenPort = 47111" >> $FILE

echo "PrivateKey = $(cat server.key)" >> $FILE
echo
cat  $FILE

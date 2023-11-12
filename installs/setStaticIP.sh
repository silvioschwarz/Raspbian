#! /bin/bash


CURRENTIP=$(hostname -I | awk '{print $1}')
ROUTERIP=$(ip r | grep "default via" | awk '{print $3}')
DNSIP=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}')

echo $DNSIP
read 


#cat /etc/resolv.conf
sudo cp /etc/resolv.conf /etc/resolv.conf.old


read -p "Enter interface: " INTERFACE
read -p "Enter static IP: " STATICIP

echo "current IP: " $CURRENTIP
echo "Gateway: " $ROUTERIP
echo "DNS IP: " $DNSIP
echo "interface : "$INTERFACE
echo "static IP: "$STATICIP

read -p "Press any key to continue... " -n1 -s -t 15

echo "write config to file  ..."

FILE="/etc/dhcpcd.conf"
LINE="interface eth0"
grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"


LINE="static routers=${ROUTERIP}"
grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"


LINE="static domain_name_servers=${DNSIP}"
grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"


LINE="static ip_address=${STATICIP}/24"
grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

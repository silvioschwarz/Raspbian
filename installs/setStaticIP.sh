#! /bin/sh


CURRENTIP=$(hostname -I | awk '{print $1}')
ROUTERIP=$(ip r | grep "default via" | awk '{print $3}')


DNSIP=$(grep "namesever" /etc/resolv.conf)

read -p "Enter interface: " INTERFACE
read -p "Enter static IP: " STATICIP

echo $CURRENTIP
echo $ROUTERIP
echo $DNSIP
echo $INTERFACE
echo $STATICIP

#FILE="/etc/dhcpcd.conf"
#LINE="interface eth0"

#grep $LINE $FILE || echo $LINE >> $FILE

#static_routers=[ROUTER IP]
#static domain_name_servers=[DNS IP]
#static ip_address=[STATIC IP ADDRESS YOU WANT]/24

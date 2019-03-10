#! /bin/sh

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X


iptables -I INPUT 1 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 53 -j ACCEPT
iptables -I INPUT 1 -p udp -m udp --dport 53 -j ACCEPT
iptables -I INPUT 1 -p udp -m tcp --dport 67 -j ACCEPT
iptables -I INPUT 1 -p udp -m udp --dport 67 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 4711 -i lo -j ACCEPT

ip6tables -I INPUT -p udp -m udp --sport 546:547 --dport 546:547 -j ACCEPT



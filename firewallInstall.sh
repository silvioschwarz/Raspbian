#!/bin/sh
iptables -A INPUT -i tun0 -p tcp --destination-port 53 -j ACCEPT
iptables -A INPUT -i tun0 -p udp --destination-port 53 -j ACCEPT
iptables -A INPUT -i tun0 -p tcp --destination-port 80 -j ACCEPT
iptables -A INPUT -p tcp --destination-port 22 -j ACCEPT
iptables -A INPUT -p tcp --destination-port 1194 -j ACCEPT
iptables -A INPUT -p udp --destination-port 1194 -j ACCEPT
iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -P INPUT DROP
iptables -A INPUT -p udp --dport 80 -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp --dport 443 -j REJECT --reject-with tcp-reset
iptables -A INPUT -p udp --dport 443 -j REJECT --reject-with icmp-port-unreachable
ip6tables -A INPUT -i tun0 -p tcp --destination-port 53 -j ACCEPT
ip6tables -A INPUT -i tun0 -p udp --destination-port 53 -j ACCEPT
ip6tables -A INPUT -i tun0 -p tcp --destination-port 80 -j ACCEPT
ip6tables -A INPUT -p tcp --destination-port 22 -j ACCEPT
ip6tables -A INPUT -p tcp --destination-port 1194 -j ACCEPT
ip6tables -A INPUT -p udp --destination-port 1194 -j ACCEPT
ip6tables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -I INPUT -i lo -j ACCEPT
ip6tables -A INPUT -p udp --dport 80 -j REJECT --reject-with icmp6-port-unreachable
ip6tables -A INPUT -p tcp --dport 443 -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -p udp --dport 443 -j REJECT --reject-with icmp6-port-unreachable
ip6tables -P INPUT DROP

iptables -L --line-numbers
echo "Chain INPUT (policy DROP)
num  target     prot opt source               destination         
1    ACCEPT     all  --  anywhere             anywhere            
2    ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
3    ACCEPT     all  --  anywhere             anywhere            
4    ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain
5    ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
6    ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http
7    ACCEPT     udp  --  anywhere             anywhere             udp dpt:80
8    ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ssh
9    ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:openvpn
10   ACCEPT     udp  --  anywhere             anywhere             udp dpt:openvpn
11   ACCEPT     tcp  --  10.8.0.0/24          anywhere             tcp dpt:domain
12   ACCEPT     udp  --  10.8.0.0/24          anywhere             udp dpt:domain
13   ACCEPT     tcp  --  10.8.0.0/24          anywhere             tcp dpt:http
14   ACCEPT     udp  --  10.8.0.0/24          anywhere             udp dpt:80
15   ACCEPT     tcp  --  10.8.0.0/24          anywhere             tcp dpt:domain
16   ACCEPT     tcp  --  10.8.0.0/24          anywhere             tcp dpt:http
17   ACCEPT     udp  --  10.8.0.0/24          anywhere             udp dpt:domain
18   ACCEPT     udp  --  10.8.0.0/24          anywhere             udp dpt:80
19   REJECT     tcp  --  anywhere             anywhere             tcp dpt:https reject-with icmp-port-unreachable

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination  "


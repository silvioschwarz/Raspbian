#!/bin/sh

wget https://git.io/vpn -O openvpn-install.sh
chmod 755 openvpn-install.sh
./openvpn-install.sh

curl -sSL https://install.pi-hole.net | bash
sudo apt install unbound
wget -O root.hints https://www.internic.net/domain/named.root
sudo mv root.hints /var/lib/unbound/


/etc/unbound/unbound.conf.d/pi-hole.conf:

echo "
server:
    # If no logfile is specified, syslog is used
    # logfile: "/var/log/unbound/unbound.log"
    verbosity: 0

    port: 5353
    do-ip4: yes
    do-udp: yes
    do-tcp: yes

    # May be set to yes if you have IPv6 connectivity
    do-ip6: no

    # Use this only when you downloaded the list of primary root servers!
    root-hints: "/var/lib/unbound/root.hints"

    # Trust glue only if it is within the servers authority
    harden-glue: yes

    # Require DNSSEC data for trust-anchored zones, if such data is absent, the zone becomes BOGUS
    harden-dnssec-stripped: yes

    # Don't use Capitalization randomization as it known to cause DNSSEC issues sometimes
    # see https://discourse.pi-hole.net/t/unbound-stubby-or-dnscrypt-proxy/9378 for further details
    use-caps-for-id: no

    # Reduce EDNS reassembly buffer size.
    # Suggested by the unbound man page to reduce fragmentation reassembly problems
    edns-buffer-size: 1472

    # TTL bounds for cache
    cache-min-ttl: 3600
    cache-max-ttl: 86400

    # Perform prefetching of close to expired message cache entries
    # This only applies to domains that have been frequently queried
    prefetch: yes

    # One thread should be sufficient, can be increased on beefy machines
    num-threads: 1

    # Ensure kernel buffer is large enough to not loose messages in traffic spikes
    so-rcvbuf: 1m

    # Ensure privacy of local IP ranges
    private-address: 192.168.0.0/16
    private-address: 169.254.0.0/16
    private-address: 172.16.0.0/12
    private-address: 10.0.0.0/8
    private-address: fd00::/8
    private-address: fe80::/10
"

sudo service unbound start
dig pi-hole.net @127.0.0.1 -p 5353



sudo apt-get install polipo ana cron

sudo nano /etc/polipo/config

#proxyAddress = "192.168.1.33"
#allowedClients = 127.0.0.1, 192.168.1.0/24
sudo service polipo restart

sudo update-rc.d polipo defaults




#curl -L https://install.pivpn.io | bash

#curl pi-proxy.net/install | bash


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
"Chain INPUT (policy DROP)
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

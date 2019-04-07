THIS_FILE := $(lastword $(MAKEFILE_LIST))


default: 
	@echo $@  # print target name	
	webserver
email: 
	@echo $@
	./emailInstall.sh
nas: 
	@echo $@
	./sambaInstall.sh
new: 
	@echo $@
	./newInstall.sh	
	./backportsInstall.sh
	sudo apt-get install --no-install-recommends xserver-xorg xinit 
	sudo apt install raspberrypi-ui-mods lightdm
notrack: 
	@echo $@
	wget https://raw.githubusercontent.com/quidsup/notrack/master/install.sh | bash 
pihole: 
	@echo $@
	curl -sSL https://install.pi-hole.net | bash
	sudo apt install unbound
	wget -O root.hints https://www.internic.net/domain/named.root
	sudo mv root.hints /var/lib/unbound/
	sudo mv pi-hole.config /etc/unbound/unbound.conf.d/pi-hole.conf
	sudo service unbound start
	dig pi-hole.net @127.0.0.1 -p 5353
	sudo ./firewallInstall.sh
proxy: 
	@echo $@
	sudo apt-get install polipo ana cron
	echo "sudo nano /etc/polipo/config #proxyAddress = "192.168.1.33" #allowedClients = 127.0.0.1, 192.168.1.0/24"
	sudo service polipo restart
	sudo update-rc.d polipo defaults
python: 
	@echo $@
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	sudo apt install python-dev python-pandas python-numpy python-scipy python-matplotlib
	pip3 install --user dash dash-html-components dash-core-components dash-table plotly dash-daq
squid: 
	@echo $@
	sudo apt-get install squid3 squidguard
	sudo cp /etc/squid3/squid.conf /etc/squid3/squid.conf.bak
	sudo cp /etc/squidguard/squidGuard.conf /etc/squidguard/squidGuard.conf.bak
tor: 
	@echo $@
	sudo apt install tor
update:
	@echo $@
	sudo apt update && sudo apt upgrade && sudo apt autoremove
vpn: 
	@echo $@
	curl -L https://install.pivpn.io | bash
webserver: 
	@echo $@
	sudo apt-get install apache2 mysql-client apache2-dev libapache2-mod-php php php-mysql mysql-server apache2-utils libexpat1 ssl-cert libapache2-mod-wsgi
	sudo ./backportsInstall.sh
	sudo apt-get install certbot python-certbot-apache -t stretch-backports



all:
	@echo $@  # print target name
	@$(MAKE) -f $(THIS_FILE) webserver pihole vpn tor notrack proxy nas python new

.PHONY: uninstall
uninstall:
	echo "still test"


.PHONY: clean
clean:
	echo "still test"
	rm -f all




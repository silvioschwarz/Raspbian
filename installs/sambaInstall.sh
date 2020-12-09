#! /bin/sh

echo "mount devices"
#mkdir
#mount devices

echo "install samba"
sudo apt install samba samba-common-bin

echo "
[Backup]
comment = Backup Ordner
path = /media/hdd1/shares
valid users = @users
force group = users
create mask = 0660
directory mask = 0771
read only = no" > ?

/etc/init.d/samba restart

echo "add user nas"
useradd nas -m -G users
passwd nas

smbpasswd -a nas

sudo nano /etc/fstab

/dev/sda1 /media/hdd1 auto noatime 0 0	

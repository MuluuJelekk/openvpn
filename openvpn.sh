#!/bin/bash

# install openvpn
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/MuluuJelekk/openvpn/master/openvpn.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/59999.conf "https://raw.githubusercontent.com/MuluuJelekk/openvpn/master/conf/59999.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
wget -O /etc/iptables.up.rules "https://raw.githubusercontent.com/arieonline/autoscript/master/conf/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/iptables.up.rules;
iptables-restore < /etc/iptables.up.rules
service openvpn restart
# configure openvpn client config
cd /etc/openvpn/
wget -O /etc/openvpn/59999-client.ovpn "https://raw.githubusercontent.com/MuluuJelekk/openvpn/master/59999-client.conf"
sed -i $MYIP2 /etc/openvpn/59999-client.ovpn;
PASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1`;
useradd -M -s /bin/false KangArie
echo "KangArie:$PASS" | chpasswd
echo "KangArie" > pass.txt
echo "$PASS" >> pass.txt
tar cf client.tar 59999-client.ovpn pass.txt
cp client.tar /home/vps/public_html/
cd

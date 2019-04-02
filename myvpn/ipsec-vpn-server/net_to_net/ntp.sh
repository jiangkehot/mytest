#! /bin/bash

set -e

yum update -y


cat >> /etc/sysctl.conf <<EOF
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.eth0.rp_filter = 0
EOF

# cat >> /etc/sysctl.conf <<EOF
# net.ipv4.ip_forward = 1
# net.ipv4.conf.default.rp_filter = 0
# net.ipv4.conf.all.accept_redirects = 0
# net.ipv4.conf.all.send_redirects = 0
# net.ipv4.conf.default.accept_redirects = 0
# net.ipv4.conf.default.send_redirects = 0
# EOF

# cat >> /etc/sysctl.conf <<EOF
# net.ipv4.ip_forward = 1
# net.ipv4.conf.all.accept_source_route = 0
# net.ipv4.conf.all.accept_redirects = 0
# net.ipv4.conf.all.send_redirects = 0
# net.ipv4.conf.all.rp_filter = 0
# net.ipv4.conf.default.accept_source_route = 0
# net.ipv4.conf.default.accept_redirects = 0
# net.ipv4.conf.default.send_redirects = 0
# net.ipv4.conf.default.rp_filter = 0
# net.ipv4.conf.eth0.rp_filter = 0
# EOF

# 关闭icmp重定向
sysctl -a | egrep "ipv4.*(accept|send)_redirects" | awk -F "=" '{print$1"= 0"}' >> /etc/sysctl.conf

sysctl -p

# 关闭SELinux
# setenforce 0

yum install openswan -y

systemctl start ipsec

ipsec --version

ipsec verify

netstat -anp | grep pluto




############################ nodes #############3
cp /etc/ipsec.conf /etc/ipsec.conf_bk

cat > /etc/ipsec.conf <<EOF
version 2.0   

config setup
	virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
	protostack=netkey
	interfaces=%defaultroute
	nat_traversal=yes
	oe=off


conn net-to-net
	authby=secret
	type=tunnel
	left=47.89.187.199
	leftsubnet=172.16.0.0/12
	leftid=@k8sServer
	leftnexthop=%defaultroute
	right=%defaultroute
	rightsubnet=172.17.0.0/16
	rightid=@BJnode001
	rightnexthop=%defaultroute
	auto=add
	ike=aes256-sha2,aes128-sha2,aes256-sha1,aes128-sha1,aes256-sha2;modp1024,aes128-sha1;modp1024
  	phase2alg=aes_gcm-null,aes128-sha1,aes256-sha1,aes256-sha2_512,aes128-sha2,aes256-sha2
  	sha2-truncbug=yes
EOF


localIP=172.17.78.51
cp /etc/ipsec.secrets /etc/ipsec.secrets_bk
cat > /etc/ipsec.secrets <<EOF
$localIP %any 0.0.0.0  : PSK "6gNFKwgbLV4BMKZL"
EOF

systemctl restart ipsec

ipsec verify

ipsec auto --up net-to-net










###############
#39.105.221.66
# 172.17.3.224
# 172.17.3.224 %any 0.0.0.0  : PSK "6gNFKwgbLV4BMKZL"
# version 2.0   

# config setup
# 	protostack=netkey
# 	nat_traversal=yes
# 	virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
# 	oe=off
# 	interfaces=%defaultroute


# conn net-to-net
# 	authby=secret
# 	type=tunnel
# 	left=172.17.3.224
# 	leftsubnet=172.16.0.0/12
# 	leftid=@test1
# 	leftnexthop=%defaultroute
# 	right=47.89.185.210
# 	rightsubnet=192.168.0.0/16
# 	rightid=@test2
# 	rightnexthop=%defaultroute
# 	auto=add


# 47.89.185.210
# 192.168.80.39
# 192.168.80.39 %any 0.0.0.0  : PSK "6gNFKwgbLV4BMKZL"
# version 2.0   

# config setup
# 	protostack=netkey
# 	nat_traversal=yes
# 	virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
# 	oe=off
# 	interfaces=%defaultroute


# conn net-to-net
# 	authby=secret
# 	type=tunnel
# 	left=39.105.221.66
# 	leftsubnet=172.16.0.0/12
# 	leftid=@test1
# 	leftnexthop=%defaultroute
# 	right=192.168.80.39
# 	rightsubnet=192.168.0.0/16
# 	rightid=@test2
# 	rightnexthop=%defaultroute
# 	auto=add







################  k8s Server ###################


cp /etc/ipsec.conf /etc/ipsec.conf_bk

cat > /etc/ipsec.conf <<EOF
version 2.0   

config setup
	virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
	protostack=netkey
	interfaces=%defaultroute
	nat_traversal=yes
	oe=off


conn net-to-net
	authby=secret
	type=tunnel
	left=%defaultroute
	leftsubnet=172.16.0.0/12
	leftid=@k8sServer
	leftnexthop=%defaultroute
	right=47.93.58.175
	rightsubnet=172.16.0.0/16
	rightid=@BJnode001
	rightnexthop=%defaultroute
	auto=add
	ike=aes256-sha2,aes128-sha2,aes256-sha1,aes128-sha1,aes256-sha2;modp1024,aes128-sha1;modp1024
  	phase2alg=aes_gcm-null,aes128-sha1,aes256-sha1,aes256-sha2_512,aes128-sha2,aes256-sha2
  	sha2-truncbug=yes
EOF


localIP=172.22.1.13
cp /etc/ipsec.secrets /etc/ipsec.secrets_bk
cat > /etc/ipsec.secrets <<EOF
$localIP %any 0.0.0.0  : PSK "6gNFKwgbLV4BMKZL"
EOF

systemctl restart ipsec

ipsec verify

ipsec auto --up net-to-net


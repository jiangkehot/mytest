#! /bin/bash
# only CentOS! 此脚本仅适用于CentOS

# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/myvpn/ipsec-vpn-server/net_to_net/ntp.sh | sh -x

set -e

yum update -y


cat >> /etc/sysctl.conf <<EOF
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.eth0.rp_filter = 0
net.ipv4.conf.all.rp_filter = 0
EOF


# 关闭icmp重定向
sysctl -a | egrep "ipv4.*(accept|send)_redirects" | awk -F "=" '{print$1"= 0"}' >> /etc/sysctl.conf

sysctl -p

# 关闭SELinux
setenforce 0

yum install openswan -y


PUBLIC_IP=$(wget -t 3 -T 15 -qO- http://ipv4.icanhazip.com) && echo $PUBLIC_IP
k8sServerIP='47.90.251.10'
serverSubnetPool='172.16.0.0/12'
localIP=$(ip addr | grep eth0 | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}') && echo $localIP
localSubnetPool=$(ip r | grep "$localIP" | awk '{print $1}') && echo $localSubnetPool


# config

cp /etc/ipsec.conf /etc/ipsec.conf_bk

cat > /etc/ipsec.conf <<EOF
version 2.0   

config setup
	virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
	protostack=netkey
	interfaces=%defaultroute
	nat_traversal=yes
	oe=off


conn net-to-$HOSTNAME
	authby=secret
	type=tunnel
	left=$k8sServerIP
	leftsubnet=$serverSubnetPool
	leftid=@k8sServer
	leftnexthop=%defaultroute
	right=%defaultroute
	rightsubnet=$localSubnetPool
	rightid=@$HOSTNAME
	rightnexthop=%defaultroute
	auto=add
	ike=aes256-sha2,aes128-sha2,aes256-sha1,aes128-sha1,aes256-sha2;modp1024,aes128-sha1;modp1024
	phase2alg=aes_gcm-null,aes128-sha1,aes256-sha1,aes256-sha2_512,aes128-sha2,aes256-sha2
	sha2-truncbug=yes
EOF


cp /etc/ipsec.secrets /etc/ipsec.secrets_bk
cat > /etc/ipsec.secrets <<EOF
$localIP %any 0.0.0.0  : PSK "6gNFKwgbLV4BMKZL"
EOF


systemctl start ipsec


cat << EOF
================================================
systemctl restart ipsec
ipsec --version
ipsec verify
ipsec whack --trafficstatus  # //查看链接状态
systemctl status -l ipsec  # //查看正在链接的设备
netstat -anp | grep pluto
ipsec auto --up net-to-$HOSTNAME
ipsec auto --down net-to-$HOSTNAME

# 关于内核模块 modprobe af_key 
# 加载内核模块
sudo modprobe af_key
# 查看内核是否被加载
lsmod | grep -i af_key
# 开机加载内核模块
cat >> /etc/modules-load.d/virtio-net.conf << EEOOFF
# Load virtio-net.ko at boot
virtio-net
EEOOFF
================================================
EOF


echo '###############服务器部分###########'
cat /etc/ipsec.secrets

sed -e s/left=$k8sServerIP/left=\%defaultroute/ -e s/right=\%defaultroute/right=$PUBLIC_IP/ /etc/ipsec.conf

echo "ipsec auto --up net-to-$HOSTNAME"





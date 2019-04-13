#! /bin/bash


################==============# Update sysctl settings #==================================###################


SYST='/sbin/sysctl -e -q -w'
if [ "$(getconf LONG_BIT)" = "64" ]; then
  SHM_MAX=68719476736
  SHM_ALL=4294967296
else
  SHM_MAX=4294967295
  SHM_ALL=268435456
fi
$SYST kernel.msgmnb=65536
$SYST kernel.msgmax=65536
$SYST kernel.shmmax=$SHM_MAX
$SYST kernel.shmall=$SHM_ALL
$SYST net.ipv4.ip_forward=1
$SYST net.ipv4.conf.all.accept_source_route=0
$SYST net.ipv4.conf.all.accept_redirects=0
$SYST net.ipv4.conf.all.send_redirects=0
$SYST net.ipv4.conf.all.rp_filter=0
$SYST net.ipv4.conf.default.accept_source_route=0
$SYST net.ipv4.conf.default.accept_redirects=0
$SYST net.ipv4.conf.default.send_redirects=0
$SYST net.ipv4.conf.default.rp_filter=0
$SYST net.ipv4.conf.eth0.send_redirects=0
$SYST net.ipv4.conf.eth0.rp_filter=0


################=================# Config Ipsec #===============================###################

PUBLIC_IP=$(wget -t 3 -T 15 -qO- http://ipv4.icanhazip.com) && echo $PUBLIC_IP
k8sServerIP='47.90.251.10'
serverSubnetPool='172.16.0.0/12'
localIP=$(ip addr | grep eth0 | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}') && echo $localIP
localSubnetPool=$(ip r | grep "$localIP" | awk '{print $1}') && echo $localSubnetPool



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
	auto=start
	ike=aes256-sha2,aes128-sha2,aes256-sha1,aes128-sha1,aes256-sha2;modp1024,aes128-sha1;modp1024
	phase2alg=aes_gcm-null,aes128-sha1,aes256-sha1,aes256-sha2_512,aes128-sha2,aes256-sha2
	sha2-truncbug=yes
EOF


cat > /etc/ipsec.secrets <<EOF
$localIP %any 0.0.0.0  : PSK "6gNFKwgbLV4BMKZL"
EOF
chmod 600 /etc/ipsec.secrets


################================================================###################


# Load IPsec kernel module
modprobe af_key

# Start services
mkdir -p /run/pluto /var/run/pluto
rm -f /run/pluto/pluto.pid /var/run/pluto/pluto.pid

/usr/local/sbin/ipsec start


################================================================###################

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

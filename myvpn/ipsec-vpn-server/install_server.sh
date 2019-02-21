#! /bin/bash

# curl -O https://raw.githubusercontent.com/jiangkehot/mytest/master/myvpn/ipsec-vpn-server/install_server.sh \
&& curl -O https://raw.githubusercontent.com/jiangkehot/mytest/master/myvpn/ipsec-vpn-server/docker-compose.yml \
&& sh -x install_server.sh ;\
rm -f install_server.sh docker-compose.yml

set -e

#预设变量
VPN_SERVER_IP=$1

read -p "输入VPN服务器IP:" VPN_SERVER_IP

# 远程查看该模块是否加载成功：ssh 47.90.242.168 'lsmod | grep -i af_key'
ssh $VPN_SERVER_IP 'sudo modprobe af_key'

#预设变量
VPN_SERVER_HOSTNAME=$2
read -p "输入VPN服务器HOSTNAME:" VPN_SERVER_HOSTNAME

#预设变量
x=$3
read -p "是否需要执行docker-machine create命令,创建HOST）请输入 ‘y/n’ ，继续下一步！" x
[ "$x" == "y" ] && docker-machine create -d generic --generic-ip-address="$VPN_SERVER_IP" "$VPN_SERVER_HOSTNAME" 

echo 'eval $(docker-machine env '"$VPN_SERVER_HOSTNAME)"' && docker-compose up -d'

#! /bin/bash

set -e

read -p "输入VPN服务器IP:" VPN_SERVER_IP

read -p "是否需要执行docker-machine create命令？请输入y/n，继续下一步！" x

[ "$x" == "y" ] && docker-machine create -d generic --generic-ip-address="$VPN_SERVER_IP" "aaa$VPN_SERVER_IP" &&  eval $(docker-machine env "aaa$VPN_SERVER_IP")

[ "$x" == "n" ] && read -p "Please input HOSTNAME:" && eval $(docker-machine env $HOSTNAME)

# 远程查看该模块是否加载成功：ssh 47.90.242.168 'lsmod | grep -i af_key'
ssh $VPN_SERVER_IP 'sudo modprobe af_key'

docker-compose up -d

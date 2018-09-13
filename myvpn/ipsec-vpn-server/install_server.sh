#! /bin/bash

set -e

read -p "输入VPN服务器IP:" VPN_SERVER_IP

read -p "是否需要执行docker-machine create命令？请输入y/n，继续下一步！" x

[ "$x" == "y" ] && docker-machine create -d generic --generic-ip-address="$VPN_SERVER_IP" testvpn

eval $(docker-machine env testvpn)

ssh $VPN_SERVER_IP 'sudo modprobe af_key'

docker-compose up -d

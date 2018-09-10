#! /bin/bash

set -e

read -p "输入VPN服务器IP:" VPN_SERVER_IP

docker-machine create -d generic --generic-ip-address="$VPN_SERVER_IP" testvpn

echo "eval $(docker-machine env testvpn)" 

ssh $VPN_SERVER_IP 'sudo modprobe af_key'

docker-compose up -d

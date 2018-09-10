#! /bin/bash

read -p "输入VPN服务器IP:" VPN_SERVER_IP

docker-machine create -d generic --generic-ip-address="$VPN_SERVER_IP" testvnp

eval $(docker-machine env testvnp) 

ssh $VPN_SERVER_IP 'sudo modprobe af_key'

docker-compose up -d

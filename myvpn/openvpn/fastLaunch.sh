#! /bin/bash

set -e

# 如果没有输入IP，则提示输入
if [[ -z "$1" ]]; then
    read -p "输入VPN服务器IP:" VPN_SERVER_IP
else
    VPN_SERVER_IP="$1"
fi

#定义数据卷名称，并创建数据卷
OVPN_DATA="ovpnData"
docker volume create --name $OVPN_DATA

# cd ./var/lib/docker/volumes/ovpnData/_data/

sh -x ./var/lib/docker/volumes/ovpnData/_data/zzzmod.sh $VPN_SERVER_IP

scp -r ./var $VPN_SERVER_IP:/ 

docker run --name myopenvpn -v ovpnData:/etc/openvpn -d -p 1194:1194/udp --restart=always --cap-add=NET_ADMIN kylemanna/openvpn

docker logs -f myopenvpn

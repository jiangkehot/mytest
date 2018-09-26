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

# 将所文件及目录中含有的‘旧服务器ip’替换为‘新服务器ip’
sh -x ./var/lib/docker/volumes/ovpnData/_data/zzzmod.sh $VPN_SERVER_IP

# 将修改后的服务器配置文件上传至新服务器
scp -r ./var $VPN_SERVER_IP:/ 

# Start OpenVPN server process
docker run --name myopenvpn -v ovpnData:/etc/openvpn -d -p 1194:1194/udp --restart=always --cap-add=NET_ADMIN kylemanna/openvpn

# 开启日志
docker logs -f myopenvpn

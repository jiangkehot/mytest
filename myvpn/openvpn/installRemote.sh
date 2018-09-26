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

#生成服务器端配置文件及证书
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://$VPN_SERVER_IP
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki

# 启动服务器 Start OpenVPN server process
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --restart=always --cap-add=NET_ADMIN kylemanna/openvpn

# 生成客户端证书  Generate a client certificate without a passphrase
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

# 导出客户端证书 Retrieve the client configuration with embedded certificates
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > myclient.ovpn

# DEBUG
# docker run -v $OVPN_DATA:/etc/openvpn -p 1194:1194/udp --privileged -e DEBUG=1 kylemanna/openvpn

# Test using a client that has openvpn installed correctly
# openvpn --config CLIENTNAME.ovpn

#! /bin/bash

set -e

read -p "输入VPN服务器IP:" VPN_SERVER_IP

#定义数据卷名称，并创建数据卷
OVPN_DATA="ovpnData"
docker volume create --name $OVPN_DATA

#配置服务器端，并生成证书
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://$VPN_SERVER_IP
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki



# 启动服务器 Start OpenVPN server process
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --restart=always --cap-add=NET_ADMIN kylemanna/openvpn


# 生成客户端证书  Generate a client certificate without a passphrase
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

# 导出客户端证书 Retrieve the client configuration with embedded certificates
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > myclient.ovpn
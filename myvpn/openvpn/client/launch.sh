#! /bin/bash

read -p "输入VPN服务器IP:" VPN_SERVER_IP
OLD_VPN_SERVER_IP='47.90.240.147'

for filename in myclient.ovpn launch.sh;do
    sed -i "s/$OLD_VPN_SERVER_IP/$VPN_SERVER_IP/g" "$filename"
done


/usr/sbin/openvpn --daemon --writepid /var/run/openvpn-client/penvpn.pid --cd /data/vpnDate/openvpn/client/ --config myclient.ovpn --log-append /var/log/openvpn.log

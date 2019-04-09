#! /bin/bash

docker pull oddrationale/docker-shadowsocks
docker run -d -p 2022:2022 oddrationale/docker-shadowsocks -s 0.0.0.0 -p 2022 -k test123 -m aes-256-cfb

# Mac
# alias awssdlaunch='ssh -NT -f -D 1080 root@18.144.29.78 && networksetup -setsocksfirewallproxystate Wi-Fi on'

# alias sdpause='/usr/local/bin/jsvpnsd'

# /usr/local/bin/jsvpnsd
# # !/bin/bash

# kill $(lsof -i:1080 | grep ssh | awk '{print $2}' | sed -n 1p)
# networksetup -setsocksfirewallproxystate 'Wi-Fi' off

#! /bin/bash

# docker pull oddrationale/docker-shadowsocks
docker run -d --restart always -p 2022:2022 oddrationale/docker-shadowsocks -s 0.0.0.0 -p 2022 -k test123 -m aes-256-cfb

# # Launch

# docker run -d --restart always -p 2022:2022 oddrationale/docker-shadowsocks -s 0.0.0.0 -p 2022 -k FJ3qi9U4IEr3R5A6HiJ351uo -m aes-256-cfb

# docker run -d --restart always -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -k FJ3qi9U4IEr3R5A6HiJ351uo -m chacha20 --fast-open"


# Mac
# alias awssdlaunch='ssh -NT -f -D 1080 root@18.144.29.78 && networksetup -setsocksfirewallproxystate Wi-Fi on'

# alias sdpause='/usr/local/bin/jsvpnsd'

# /usr/local/bin/jsvpnsd
# # !/bin/bash

# kill $(lsof -i:1080 | grep ssh | awk '{print $2}' | sed -n 1p)
# networksetup -setsocksfirewallproxystate 'Wi-Fi' off

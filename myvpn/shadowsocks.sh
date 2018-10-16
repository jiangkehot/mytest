#! /bin/bash

docker pull oddrationale/docker-shadowsocks
docker run -d -p 2022:2022 oddrationale/docker-shadowsocks -s 0.0.0.0 -p 2022 -k test123 -m aes-256-cfb

#! /bin/bash

#安装docker(Ubuntu)


#当shell语句错误即停止，防止错误继续执行
set -e

#更新源&升级软件
apt update && apt upgrade

# 安装包，允许 apt 命令 HTTPS 访问 Docker 源。
sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
software-properties-common


# 添加 Docker 官方的 GPG
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

 


# 将 Docker 的源添加到 /etc/apt/sources.list
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
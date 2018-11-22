#! /bin/bash

#安装docker

# 方式一
# curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun


#当shell语句错误即停止，防止错误继续执行
set -e

#更新源&升级软件
sudo apt update && apt upgrade -y


#官方方式：安装docker
curl -fsSL https://get.docker.com/ | sh -x

#docker加速
#aliyun加速器
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://0po41ixf.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
#daocloud加速器
#curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://a13e0e77.m.daocloud.io


# #cloudman的方式 安装docker(Ubuntu)
# # 安装包，允许 apt 命令 HTTPS 访问 Docker 源。
# sudo apt-get install \
# apt-transport-https \
# ca-certificates \
# curl \
# software-properties-common

# # 添加 Docker 官方的 GPG
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# # 将 Docker 的源添加到 /etc/apt/sources.list
# sudo add-apt-repository \
# "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
# $(lsb_release -cs) \
# stable"

# #安装docker社区版
# sudo apt-get install docker-ce -y

# #docker加速
# curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://a13e0e77.m.daocloud.io
 

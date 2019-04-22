#! /bin/bash
#curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/installDocker.sh | sh -s 18.06.2.ce-3.el7 -x   // -s 指定版本参数

#安装docker

# 方式一
# curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun


#当shell语句错误即停止，防止错误继续执行
set -e

#更新源&升级软件
#sudo apt update && apt upgrade -y


#官方方式：安装docker
#curl -fsSL https://get.docker.com/ | sh -x

#CentOS

#安装必要的一些系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
#添加docker的阿里云的源
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#更新并安装相应版本
sudo yum makecache fast
[ -z $1 ] && sudo yum -y install docker-ce || sudo yum -y install docker-ce-$1
#设置开机启动，并启动docker
sudo systemctl enable docker && sudo systemctl start docker


#docker加速
#aliyun加速器
#sudo mkdir -p /etc/docker
#sudo tee /etc/docker/daemon.json <<-'EOF'
#{
#  "registry-mirrors": ["https://0po41ixf.mirror.aliyuncs.com"]
#}
#EOF
#sudo systemctl daemon-reload
#sudo systemctl restart docker
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

echo '安装docker-machine：curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/installDockerMachine.sh | sh -x'
 

#! /bin/bash

#安装docker-machine,并添加docker-machine补全功能的脚本

#当shell语句错误即停止，防止错误继续执行
set -e

#设置系统时间为CTS时间
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#替换为阿里云的源：
cp  /etc/apt/sources.list  /etc/apt/sources.list_bak && sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && sudo apt update && apt-get update

#安装docker
#curl -fsSL https://github.com/jiangkehot/mytest/blob/master/docker/installDocker.sh | sh -x 


#安装docker-machine
curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/installDockerMachine.sh|sh -x


#添加docker-machine补全功能的脚本
#curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/dockerMachineCompletion.sh|sh -x


#生成秘钥对
#root秘钥对
# sudo ssh-keygen -t rsa -C "jiangkehot@root"
sudo cp -r /vagrant/.vagrant/.ssh/id_rsa* /root/.ssh/
#vagrant秘钥对
# ssh-keygen -t rsa -C "jiangkehot@vagrant"




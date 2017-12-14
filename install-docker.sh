#! /bin/bash

# This is my first shell script!
#Writen down by Aming 2017-12-12

#设置系统时间为CTS时间
#ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 更新yum源并安装docker
yum update -y && curl -fsSL https://get.docker.com/ | sh

#启动docker服务
systemctl start docker

#pull centos的latest镜像
docker pull centos

#创建docker-SSH镜像
dfpath=/root/ssh
mkdir $dfpath
wget -P /root/ssh raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh
docker build -t centos:ssh -f $dfpath/dockerfile-ssh $dfpath

#创建git服务器
dfpath=/root/git
mkdir $dfpath
docker build -t centos:git -f 'raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-git' $dfpath

#启动git-server容器
docker run --name git -h git -p 2222:22 -itd centos:git

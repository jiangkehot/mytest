#! /bin/bash

# This is my first shell script!
# Writen down by Aming 2017-12-12

#当shell语句错误即停止，防止错误继续执行
set -e

#设置系统时间为CTS时间
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#更新yum源
yum update -y

#安装docker
curl -fsSL https://get.docker.com/ | sh

#启动docker服务
systemctl start docker

#pull centos的latest镜像
docker pull centos

#创建docker-SSH镜像
dfpath=/root/ssh
mkdir $dfpath
wget -P $dfpath raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh
docker build -t centos:ssh -f $dfpath/dockerfile-ssh $dfpath

#创建git服务器
dfpath=/root/git
mkdir $dfpath
wget -P $dfpath 'https://raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-git'
docker build -t centos:git -f $dfpath/dockerfile-git $dfpath

#启动git-server容器
docker run --name git -h git -p 2222:22 -itd centos:git

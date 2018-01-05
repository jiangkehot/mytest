#! /bin/bash

#当shell语句错误即停止，防止错误继续执行
set -e

#设置系统时间为CTS时间
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#更新yum源
yum update -y

#安装工具
yum install -y wget net-tools

#安装docker
curl -fsSL https://get.docker.com/ | sh
#启动docker服务
systemctl start docker
#pull centos的latest镜像
docker pull centos

#更新docker并创建SSH镜像
#方法一
#mkdir /root/ssh
#wget -P /root/ssh raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh
#docker build -t centos:ssh -f /root/ssh/dockerfile-ssh /root/ssh
#方法二
docker build -t centos:ssh https://raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh

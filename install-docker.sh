#! /bin/bash

# This is my first shell script!
#Writen down by Aming 2017-12-12

# 更新yum源并安装docker
yum update -y && curl -fsSL https://get.docker.com/ | sh

#启动docker服务
systemctl start docker

#pull centos的latest镜像
docker pull centos

#启动第一个容器
#docker run -it centos

#下载Dockerfile文件
wget raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh

#创建docker-SSH镜像
docker build -t centos:ssh -f dockerfile-ssh .

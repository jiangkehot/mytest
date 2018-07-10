#! /bin/bash

#准备docker-machine的node环境

#当shell语句错误即停止，防止错误继续执行
set -e

#设置系统时间为CTS时间
# ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#替换为阿里云的源：
# cp  /etc/apt/sources.list  /etc/apt/sources.list_bak && sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

#更新&升级
# sudo apt update && apt-get update

#将manager对应公钥在验证表里注册，配置免密登录
sudo cat /vagrant/ssh/id_rsa.pub > /root/.ssh/authorized_keys
sudo curl https://raw.githubusercontent.com/jiangkehot/mytest/master/ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# #docker加速


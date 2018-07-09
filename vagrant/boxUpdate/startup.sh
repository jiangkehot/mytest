#! /bin/bash

#当shell语句错误即停止，防止错误继续执行
set -e

#创建目录并初始化
#创建并进入目录virtualboxbase
vmdirname=virtualboxbase
mkdir $vmdirname && cd $vmdirname
#vagrant初始化目录
read -p "请输入要初始化的box" boxname
vagrant init $boxname
#添加vagrant启动时执行的shell脚本路径
sed -i "16a\  config.vm.provision \"shell\", path: \"boxUpdate.sh\"" Vagrantfile

#下载sh脚本
wget -P ./ https://raw.githubusercontent.com/jiangkehot/mytest/master/vagrant/boxUpdate/boxUpdate.sh

#启动虚拟机（根据shell脚本更新centos，并下载docker和更新docker镜像）
vagrant up

#更新docker
#vagrant ssh
#echo 'vagrant'|su -
#systemctl start docker
#docker build -t centos:ssh https://raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh
#exit && exit

boxnameUpdate="$boxname"_update
#一切更新完毕之后，使用vagrant package打包生成virtualbox
vagrant package --output boxnameUpdate

#将更新后的box文件添加至box镜像
vagrant box add boxnameUpdate ./boxnameUpdate

#移除虚拟机，仅保留镜像
vagrant destroy -f

#移除环境
cd .. && rm -rf $vmdirname

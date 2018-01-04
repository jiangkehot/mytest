#! /bin/bash

#当shell语句错误即停止，防止错误继续执行
set -e

#创建并进入目录virtualboxbase
mkdir virtualboxbase && cd virtualboxbase

#vagrant初始化目录
vagrant init centos/7

#获取行号
#sed -n '/centos\/7/=' vagrantfile |sed -n "1"p

#修改初始化后的Vagrantfile文件，添加可以执行外部sh脚本的语句
sed -i "16a\  config.vm.provision \"shell\", path: \"virtualbox_centos_docker.sh\"" Vagrantfile


#下载sh脚本
wget -P ./ raw.githubusercontent.com/jiangkehot/jiang_test/920bb35de0a82311c908cafd0787239c1ce9d5d2/vagrant/virtualbox_centos_docker.sh

#启动虚拟机
vagrant up

#vagrant package 打包生成virtualbox
vagrant package --output CentOS7_docker
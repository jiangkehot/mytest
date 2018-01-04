#! /bin/bash

#当shell语句错误即停止，防止错误继续执行
set -e

#Mac下安装gnu-sed
#brew install gnu-sed --with-default-names
#echo "export PATH=\"\/usr\/local\/opt\/gnu-sed\/libexec\/gnubin:$PATH\”" >> ~/.zshrc
#source ~/.zshrc

#创建并进入目录virtualboxbase
vmdirname=virtualboxbase
mkdir virtualboxbase && cd $vmdirname

#vagrant初始化目录
vagrant init centos/7

#获取行号
#sed -n '/centos\/7/=' vagrantfile |sed -n "1"p

#修改初始化后的Vagrantfile文件
vmhostname=virtualboxbase
#添加可以执行外部sh脚本的语句
sed -i "16a\  config.vm.provision \"shell\", path: \"virtualbox_centos_docker.sh\"" Vagrantfile
#命名host
sed -i "16a\  config.vm.hostname = \"$vmhostname\"" Vagrantfile
#命名vmname
sed -i "16a\  end" Vagrantfile
sed -i "16a\      v.customize \[\"modifyvm\", :id, \"--name\", \"$vmhostname\", \"--memory\", \"512\"\]" Vagrantfile
sed -i "16a\  config.vm.provider \"virtualbox\" do \|v\|" Vagrantfile

#下载sh脚本
wget -P ./ raw.githubusercontent.com/jiangkehot/jiang_test/920bb35de0a82311c908cafd0787239c1ce9d5d2/vagrant/virtualbox_centos_docker.sh

#启动虚拟机
vagrant up

#vagrant package 打包生成virtualbox
vagrant package --output CentOS7_docker

#添加box
vagrant box add CentOS7_docker ./CentOS7_docker

#移除虚拟机
vagrant destroy $vmhostname

#移除环境
cd .. && rm -rf $vmdirname

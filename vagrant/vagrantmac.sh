#! /bin/bash

#当shell语句错误即停止，防止错误继续执行
set -e

#Mac下安装gnu-sed
#brew install gnu-sed --with-default-names
#echo "export PATH=\"\/usr\/local\/opt\/gnu-sed\/libexec\/gnubin:$PATH\”" >> ~/.zshrc
#source ~/.zshrc

#创建目录并初始化
#创建并进入目录virtualboxbase
vmdirname=virtualboxbase
mkdir virtualboxbase && cd $vmdirname
#vagrant初始化目录
vagrant init centos/7

#配置Vagrantfile
#获取行号
#sed -n '/centos\/7/=' vagrantfile |sed -n "1"p
#添加可以执行外部sh脚本的语句
sed -i "16a\  config.vm.provision \"shell\", path: \"virtualbox_centos_docker.sh\"" Vagrantfile
#命名host
vmhostname=virtualboxbase
sed -i "16a\  config.vm.hostname = \"$vmhostname\"" Vagrantfile
#命名vmname
sed -i "16a\  end" Vagrantfile
sed -i "16a\      v.customize \[\"modifyvm\", :id, \"--name\", \"$vmhostname\", \"--memory\", \"512\"\]" Vagrantfile
sed -i "16a\  config.vm.provider \"virtualbox\" do \|v\|" Vagrantfile

#下载sh脚本
wget -P ./ raw.githubusercontent.com/jiangkehot/jiang_test/920bb35de0a82311c908cafd0787239c1ce9d5d2/vagrant/virtualbox_centos_docker.sh

#启动虚拟机（根据shell脚本更新centos，并下载docker和更新docker镜像）
vagrant up

#一切更新完毕之后，使用vagrant package打包生成virtualbox
vagrant package --output CentOS7_docker

#将更新后的box文件添加至box镜像
vagrant box add CentOS7_docker ./CentOS7_docker

#移除虚拟机，仅保留镜像
vagrant destroy $vmhostname

#移除环境
cd .. && rm -rf $vmdirname

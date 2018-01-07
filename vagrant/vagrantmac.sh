#! /bin/bash

#当shell语句错误即停止，防止错误继续执行
set -e

#Mac下安装gnu-sed
#brew install gnu-sed --with-default-names
#echo "export PATH=\"\/usr\/local\/opt\/gnu-sed\/libexec\/gnubin:$PATH\”" >> ~/.zshrc
#source ~/.zshrc

#安装vagrant 和 virtualbox
#brew cask install virtualbox vagrant

#安装插件vbgues解决共享目录问题（即新创建的vm中若没有Guest Additions，则无法与宿主主机共享目录），此插件可自动匹配版本并安装Guest Additions
#vagrant plugin install vagrant-vbgues

#add box centos/7
#vagrant box add centos\/7

#创建目录并初始化
#创建并进入目录virtualboxbase
vmdirname=virtualboxbase
mkdir $vmdirname && cd $vmdirname
#vagrant初始化目录
vagrant init centos/7

#配置Vagrantfile
#GNU-sed
#获取行号
#sed -n '/centos\/7/=' vagrantfile |sed -n "1"p
#添加可以执行外部sh脚本的语句
sed -i "16a\  config.vm.provision \"shell\", path: \"virtualbox_centos_docker.sh\"" Vagrantfile
#配合插件vbgues，修改Vagrantfile文件中共享目录的type
sed -i "16a\  config.vm.synced_folder \".\", \"\/vagrant\", type: \"virtualbox\"" Vagrantfile
#命名host
vmhostname=virtualboxbase
sed -i "16a\  config.vm.hostname = \"$vmhostname\"" Vagrantfile
#命名vmname
sed -i "16a\  end" Vagrantfile
sed -i "16a\      v.customize \[\"modifyvm\", :id, \"--name\", \"$vmhostname\", \"--memory\", \"512\"\]" Vagrantfile
sed -i "16a\  config.vm.provider \"virtualbox\" do \|v\|" Vagrantfile

##Mac sed
#sed -i '' '16a\
#\  config.vm.provision \"shell\", path: \"virtualbox_centos_docker.sh\"
#' Vagrantfile
##配合插件vbgues，修改Vagrantfile文件中共享目录的type
#sed -i '' '16a\
#\  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
#' Vagrantfile
##命名host
#vmhostname=virtualboxbase
#sed -i '' '16a\
#\  config.vm.hostname = \"$vmhostname\"
#' Vagrantfile
##命名vmname
#sed -i '' '16a\
#\  end
#' Vagrantfile
#sed -i '' '16a\
#\    v.customize \[\"modifyvm\", :id, \"--name\", \"$vmhostname\", \"--memory\", \"512\"\]
#' Vagrantfile
#sed -i '' '16a\
#\  config.vm.provider \"virtualbox\" do \|v\|
#' Vagrantfile


#下载sh脚本
wget -P ./ https://raw.githubusercontent.com/jiangkehot/jiang_test/master/vagrant/virtualbox_centos_docker.sh

#启动虚拟机（根据shell脚本更新centos，并下载docker和更新docker镜像）
vagrant up

#更新docker
#vagrant ssh
#echo 'vagrant'|su -
#systemctl start docker
#docker build -t centos:ssh https://raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh
#exit && exit

#一切更新完毕之后，使用vagrant package打包生成virtualbox
vagrant package --output CentOS7_docker

#将更新后的box文件添加至box镜像
vagrant box add CentOS7_docker ./CentOS7_docker

#移除虚拟机，仅保留镜像
vagrant destroy -f

#移除环境
cd .. && rm -rf $vmdirname

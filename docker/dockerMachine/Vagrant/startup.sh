#! /bin/bash

#可以使用以下命令在本地执行此脚本，其中sh -s 'XXXX'为提供参数命令
#curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/Vagrant/Vagrantfile/startup.sh | sh -s 'newDir' -x

#当shell语句错误即停止，防止错误继续执行
set -e


#创建并进入目录Vagrant
mkdir dmVagrant$1 && cd dmVagrant$1


#下载sh脚本
scripts=( Vagrantfile vagrantup.sh vagrantupnode.sh )
for i in "${scripts[@]}"; do 
	sudo wget https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/Vagrant/${i} \
	-P ./
done

#启动虚拟机（根据shell脚本更新centos，并下载docker和更新docker镜像）
vagrant up


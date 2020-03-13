#! /bin/bash

#可以使用以下命令在本地执行此脚本，其中sh -s 'XXXX'为提供参数命令
#curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/vagrant/boxUpdate/startup.sh | sh -s 'ubuntu/trusty64' -x

#当shell语句错误即停止，防止错误继续执行
set -e

# 抛出错误的函数
exiterr()  { echo "Error: $1" >&2; exit 1; }

#显示当前box列表
vagrant box list

#创建目录并初始化
#创建并进入目录virtualboxbase
vmdirname=virtualboxbase
mkdir $vmdirname && cd $vmdirname


echo 'Box样例，如 centos/7 、ubuntu/xenial64 、ubuntu/trusty64 等'
echo '具体请打开VagrantCloud官网查看 https://app.vagrantup.com/boxes/search'

# boxName的获取方式对应着两种shell的执行方式，
# 1）通过子shell执行时，利用位置参数$1获取
# 2）本地shell执行(source 或 .)，利用read函数与用户交互获取
read -p "请输入要初始化的box：" boxname

# 注意的boxname得加变量符号，因为这里是要引用变量$boxname里的值，而非字符串boxname，同时注意引号，因为要取值所以必须是双引号。
boxname=${1:-"$boxname"}

if [ -z $boxname ]; then
	exiterr "Box名字不能为空，如 centos/7 、ubuntu/xenial64 、ubuntu/trusty64 等，\n如果通过source执行本脚本，请通过提示输入，\n如果通过sh执行，请在sh -e 后添加Box的名字,如sh -s 'ubuntu/trusty64'"
fi

#vagrant初始化目录
vagrant init $boxname


#添加vagrant启动时执行的shell脚本路径
if [ `uname` = "Linux" ]; then
	#statements
	sed -i "16a\  config.vm.provision \"shell\", path: \"boxUpdate.sh\"" Vagrantfile
fi

if [ `uname` = "Darwin" ]; then
	#Mac版本sed命令
	sed -i '' '16a\
	\  config.vm.provision \"shell\", path: \"boxUpdate.sh\"
	' Vagrantfile
fi

#下载sh脚本
[ -f boxUpdate.sh ] || wget https://raw.githubusercontent.com/jiangkehot/mytest/master/vagrant/boxUpdate/boxUpdate.sh

#启动虚拟机（根据shell脚本更新centos，并下载docker和更新docker镜像）
vagrant up

#更新docker
#vagrant ssh
#echo 'vagrant'|su -
#systemctl start docker
#docker build -t centos:ssh https://raw.githubusercontent.com/jiangkehot/jiang_test/master/dockerfile-ssh
#exit && exit

boxnameUpdate="$boxname"_`date "+%Y%m%d"`
#一切更新完毕之后，使用vagrant package打包生成virtualbox
vagrant package --output $boxnameUpdate

#将更新后的box文件添加至box镜像
vagrant box add $boxnameUpdate ./$boxnameUpdate

#移除虚拟机，仅保留镜像
vagrant destroy -f

#移除环境
cd .. && rm -rf $vmdirname

#生产新box后再次显示box列表
vagrant box list

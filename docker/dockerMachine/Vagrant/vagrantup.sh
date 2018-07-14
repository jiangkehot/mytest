#! /bin/bash

#准备docker-machine的manager环境

#当shell语句错误即停止，防止错误继续执行
set -e

#设置系统时间为CTS时间
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#替换为阿里云的源：
# cp  /etc/apt/sources.list  /etc/apt/sources.list_bak && sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && sudo apt update && apt-get update
curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/apt/apt_repo.sh | sh -x 

#安装docker
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/installDocker.sh | sh -x 


#安装docker-machine
curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/installDockerMachine.sh|sh -x

#生成秘钥对
# sudo cp -r /vagrant/ssh/id_rsa* /root/.ssh/
sudo ssh-keygen -t rsa -b 2048 -f /root/.ssh/manager_rsa_key -N '' -C "root_jiang@manager"
mkdir -p /vagrant/.vagrant/myssh && sudo cp -r /root/.ssh/manager_rsa_key* /vagrant/.vagrant/myssh/
sudo curl https://raw.githubusercontent.com/jiangkehot/mytest/master/ssh/id_rsa.pub >> /root/.ssh/authorized_keys
# sudo ssh-keygen -t rsa -C "jiangkehot@root"
# sudo cp -r /home/vagrant/.ssh/id_rsa* /root/.ssh/
# sudo cat /home/vagrant/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys




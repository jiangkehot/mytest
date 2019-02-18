#! /bin/bash

# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/installDockerMachine.sh | sh -x

#当shell语句错误即停止，防止错误继续执行
set -e

echo 'docker-machine 教程页面：https://docs.docker.com/machine/install-machine/'

#安装docker-machine
read -p '请输入相应版本的下载地址，如=https://github.com/docker/machine/releases/download/v0.16.0' base
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/usr/local/bin/docker-machine && chmod +x /usr/local/bin/docker-machine


#添加docker-machine补全功能的脚本
#因为ubuntu执行时报错，原因是dash作怪，因此执行时声明是bash,不是写sh
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/dockerMachineCompletion.sh| sh -x
curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/dockerMachineCompletion.sh| bash -x

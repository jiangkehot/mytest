#! /bin/bash

#当shell语句错误即停止，防止错误继续执行
set -e


#安装docker-machine
curl -L https://github.com/docker/machine/releases/download/v0.9.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && chmod +x /tmp/docker-machine && sudo cp /tmp/docker-machine /usr/local/bin/docker-machine


#添加docker-machine补全功能的脚本
#因为ubuntu执行时报错，原因是dash作怪，因此执行时声明是bash,不是写sh
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/dockerMachineCompletion.sh| sh -x
curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/dockerMachineCompletion.sh| bash -x
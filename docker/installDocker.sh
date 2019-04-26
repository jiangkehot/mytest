#! /bin/bash
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/installDocker.sh | sh -s aliyun 18.09.5-3.el7 -x   // -s 指定版本参数
# echo '查看docker-ce版本的命令：yum list docker-ce.x86_64 --showduplicates | sort -r' 
# echo '查看本机docker版本命令：1)docker version  2)rpm -aq | grep docker'

# CentOS安装docker 
# 当shell语句错误即停止，防止错误继续执行
set -e

# 安装必要的一些系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# 添加docker源
if [ -z $1 ]; then
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
else
    sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    
    # docker加速 aliyun加速器
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://0po41ixf.mirror.aliyuncs.com"]
}
EOF
    #sudo systemctl daemon-reload && sudo systemctl restart docker
fi

#更新并安装相应版本
sudo yum makecache fast
[ -z $2 ] && sudo yum -y install docker-ce || sudo yum -y install docker-ce-$1
#设置开机启动，并启动docker
sudo systemctl enable docker && sudo systemctl start docker


# 官方脚本安装docker
# curl -fsSL https://get.docker.com/ | sh -x
# 官方脚本指定aliyun镜像源
# curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

echo '安装docker-machine：curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/installDockerMachine.sh | sh -x'

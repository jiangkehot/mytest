#! /bin/bash

# alias mymounts='read -p "输入服务器IP：" serverIP && ssh root@${serverIP} "curl https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/mount.sh" | sh -x'

# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/mount.sh | sh -x

# vim /etc/rc.d/rc.local

# 判断是否安装了NFS客户端，如果没有，则自动安装
rpm -q nfs-utils || sudo yum install -y nfs-utils

x=xfu82

# 判断是否存在目录/data，如果没有，自动创建，然后挂载data目录
[ -d /data/ ] || mkdir /data && sudo mount -t nfs -o vers=4.0,noresvport 17b7148e89-$x.cn-beijing.nas.aliyuncs.com:/ /data

# 挂载/root目录
sudo mount -t nfs -o vers=4.0,noresvport 17b7148e89-$x.cn-beijing.nas.aliyuncs.com:/root /root

#判断是否存在用户jiangke，如果没有，自动创建，然后挂载jiangke的家目录
[ `grep 'jiangke' /etc/passwd` ] || useradd -m -G root,wheel jiangke && sudo mount -t nfs -o vers=4.0,noresvport 17b7148e89-$x.cn-beijing.nas.aliyuncs.com:/home/jiangke /home/jiangke

#! /bin/bash

# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/mount.sh | sh -x

# vim /etc/rc.d/rc.local

# 判断是否存在目录/data，如果没有，自动创建，然后挂载data目录
[ -d /data/ ] || mkdir /data && sudo mount -t nfs -o vers=4.0,noresvport 17b7148e89-uho45.cn-beijing.nas.aliyuncs.com:/ /data

# 挂载/root目录
sudo mount -t nfs -o vers=4.0,noresvport 17b7148e89-uho45.cn-beijing.nas.aliyuncs.com:/root /root

#判断是否存在用户jiangke，如果没有，自动创建，然后挂载jiangke的家目录
[ `grep 'jiangke' /etc/passwd` ] || useradd -m -g root,wheel,docker jiangke && sudo mount -t nfs -o vers=4.0,noresvport 17b7148e89-uho45.cn-beijing.nas.aliyuncs.com:/home/jiangke /home/jiangke

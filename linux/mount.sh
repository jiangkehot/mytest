#! /bin/bash

# alias mymounts='read -p "输入服务器IP：" serverIP && ssh root@${serverIP} "curl https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/mount.sh | sh -x"'

# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/mount.sh | sh -x

# vim /etc/rc.d/rc.local  # 自动挂载推荐使用/etc/fstab，而非/etc/rc.d/rc.local，如果使用/etc/rc.d/rc.local，需要添加执行权限，+x

# 判断是否安装了NFS客户端，如果没有，则自动安装
rpm -q nfs-utils || sudo yum install -y nfs-utils

# 激活环境变量
source my.env 

nfsid=${mynfsid:-'17b7148e89'}
vswid=${myvswid:-'xfu82'}


# 判断是否存在目录/data，如果没有，自动创建，然后挂载data目录
[ -d /data/ ] || mkdir /data && sudo mount -t nfs -o vers=4.0,noresvport $nfsid-$vswid.cn-beijing.nas.aliyuncs.com:/ /data

# 挂载/root目录
sudo mount -t nfs -o vers=4.0,noresvport $nfsid-$vswid.cn-beijing.nas.aliyuncs.com:/root /root

#判断是否存在用户jiangke，如果没有，自动创建，然后挂载jiangke的家目录
[ `grep 'jiangke' /etc/passwd` ] || useradd -m -G root,wheel jiangke && sudo mount -t nfs -o vers=4.0,noresvport $nfsid-$vswid.cn-beijing.nas.aliyuncs.com:/home/jiangke /home/jiangke


# 自动挂载

# 声明字典
declare -A mountPoint
mountPoint=([/]="/data" [/root]="/root" [/home/jiangke]="/home/jiangke")

for name in $(echo ${!mountPoint[*]}); do
  [ grep "$name ${mountPoint[$name]}" /etc/fstab ] || cat >> /etc/fstab <<EOF
  $nfsid-$vswid.cn-beijing.nas.aliyuncs.com:$name ${mountPoint[$name]} nfs4 vers=4.0,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev,noresvport 0 0
  EOF
done

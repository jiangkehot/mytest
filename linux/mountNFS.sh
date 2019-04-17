#! /bin/bash
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/mountNFS.sh | sh -x

# 判断是否安装了NFS客户端，如果没有，则自动安装
rpm -q nfs-utils || sudo yum install -y nfs-utils

# 激活环境变量
source ./my.env 
nfsid=${mynfsid:-'17b7148e89'}
vswid=${myvswid:-'xfu82'}


# 声明字典
declare -A mountPoint
mountPoint=([/]="/data" [/root]="/root" [/home]="/home")

for path in $(echo ${!mountPoint[*]}); do
  # 判断挂载点是否存在，如果没有则自动创建，然后挂载
  [ -d ${mountPoint[$path]} ] || mkdir -p ${mountPoint[$path]} && sudo mount -t nfs -o vers=4.0,noresvport $nfsid-$vswid.cn-beijing.nas.aliyuncs.com:$path ${mountPoint[$path]}
  # 添加自动挂载，自动挂载推荐使用/etc/fstab，而非/etc/rc.d/rc.local，如果使用/etc/rc.d/rc.local，需要添加执行权限，+x
  if ! grep "$path ${mountPoint[$path]}" /etc/fstab > /dev/null; then
    echo "$nfsid-$vswid.cn-beijing.nas.aliyuncs.com:$path ${mountPoint[$path]} nfs4 vers=4.0,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev,noresvport 0 0" >> /etc/fstab
  fi
done

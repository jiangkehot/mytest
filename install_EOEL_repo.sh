#! /bin/bash/

#安装
yum -y install epel-release

#更新源
yum clean all && yum makecache

#查看更新后的源
cd /etc/yum.repos.d/;ll

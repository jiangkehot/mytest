#! /bin/bahs

set -x

# 修改hostname
echo 'bjadmin' > /etc/hostname 

yum update -y && yum upgrade -y

curl https://raw.githubusercontent.com/jiangkehot/mytest/master/ssh/is_rsa.pub > ~/.ssh/authorized_keys


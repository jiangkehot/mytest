#! /bin/bahs

set -x

yum update -y && yum upgrade -y

curl https://raw.githubusercontent.com/jiangkehot/mytest/master/ssh/is_rsa.pub > ~/.ssh/authorized_keys


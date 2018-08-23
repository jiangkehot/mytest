#! /bin/bash


set -x

yum update -y && yum upgreade -y

curl https://raw.githubusercontent.com/jiangkehot/mytest/master/ssh/id_rsa.pub > ~/.ssh/authorized_keys


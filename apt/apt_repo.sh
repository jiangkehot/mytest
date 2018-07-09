#! /bin/bash

#替换为国内源以提高访问速度

#当shell语句错误即停止，防止错误继续执行
set -e

#设置系统时间为CTS时间
# ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#替换为阿里云的源：
# cp  /etc/apt/sources.list  /etc/apt/sources.list_bak && sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && sudo apt update && apt-get update
#备份源 
cp  /etc/apt/sources.list  /etc/apt/sources.list_bak

#替换阿里云的源
sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

#更新源（并升级软件包）
# sudo apt update && apt-get update
# sudo apt update && apt upgrade
sudo apt update

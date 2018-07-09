#! /bin/bash

#设置系统时间为local time

#当shell语句错误即停止，防止错误继续执行
# set -e

#设置系统时间为CTS时间
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

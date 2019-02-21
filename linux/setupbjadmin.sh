# !/bin/bash

# curl -O https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/setupbjadmin.sh && sh -x setupbjadmin.sh ; rm -f setupbjadmin.sh ; mymounts ; dream

set -e

# 激活非交互shell下的别名功能
source ~/.bashrc

#更新&升级
dream yum update -y

#挂载 root & data 目录：
mymounts

#安装指定版本docker：
dream 'curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/installDocker.sh | sh -s 18.06.2.ce-3.el7 -x'

#将jiangke添加至docker组：
dream 'usermod -aG docker jiangke'

#安装docker-machine：
dream 'cp /root/local/bin/docker-machine /usr/local/bin/docker-machine && curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/dockerMachineCompletion.sh | sh -x'

#安装k8s：
dream 'curl https://raw.githubusercontent.com/jiangkehot/mytest/master/k8/k8Setup.sh | sh -x'


##设置定时任务：
echo 'crontab -e  0 3 * * * sh /data/bak/root/todolist/todolist.sh'

#重命名&重启：
rebjadmin

sleep 20

# 登录服务器
dream

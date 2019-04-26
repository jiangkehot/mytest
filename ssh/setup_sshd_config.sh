#! /bin/bash/

#SSH免密登录

#当shell语句错误即停止，防止错误继续执行
set -e

####### 服务器端 #######

# 设置root密码
# sudo -i
# passwd
# echo 'root:ssh123456' |chpasswd

#PermitRootLogin 
	#yes:允许root登录; 
	#no:不允许登录；
	#prohibit-password：允许秘钥，但禁止密码登录
#允许root登录，即PermitRootLogin yes
#sed -i 's/PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/g' /etc/ssh/sshd_config

#允许密码登录
#sed -i 's/PasswordAuthentication\ no/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config

#重启sshd服务
#systemctl restart sshd.service



####### 客户端 #######

#复制公钥到服务器
#ssh-copy-id root@192.168.56.101



####### 再次修改服务器端 #######

#改回root仅支持秘钥登录设置

sed -i 's/PermitRootLogin\ yes/PermitRootLogin\ prohibit-password/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication\ yes/PasswordAuthentication\ no/g' /etc/ssh/sshd_config
systemctl restart sshd.service




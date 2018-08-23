#! /bin/bash
# 自建shell命令:cdl = cd && ll  (打开目录，并列出所有内容)
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/bash_conf/cdl.sh -o /usr/local/sbin/cdl && chmod +x /usr/local/sbin/cdl && source cdl

function cdl(){

	if [ -z "$1" ]; then
	  	dir=$HOME
  	else
  		dir=$1
	fi  


	if [ -d "$dir" ]; then
		cd "$dir" && ls -la "$dir"
	else
		echo "$dir不是目录"
	fi  	
}

cdl "$dir"

#! /bin/bash
# 自建shell命令:cdl = cd && ll  (打开目录，并列出所有内容)
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/bash_conf/cdl.sh -o /usr/local/sbin/cdl && chmod +x /usr/local/sbin/cdl && source cdl

function cdl(){

	if [ -z "$1" ]; then
	  	dir=$HOME
  	elif [ -z `grep '^/' "$1"` ]; then
  		if [[ "$PWD" == '/' ]]; then  # bug：字符串比较不能用数学比较符-eq，需要用==
  			dir="/$1"
  		else
  			dir="$PWD/$1"
  		fi
  	else
		dir=$1
	fi  


	if [ -d "$dir" ]; then
		cd "$dir" && ls -lah "$dir"
	else
		echo "$dir不是目录"
	fi  	
}

cdl "$dir"

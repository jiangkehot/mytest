#! /bin/bash
# 自建shell命令:cdl = cd && ll  (打开目录，并列出所有内容)

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

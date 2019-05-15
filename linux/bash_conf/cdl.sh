#! /bin/bash
# 自建shell命令:cdl = cd && ll  (打开目录，并列出所有内容)
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/bash_conf/cdl.sh -o ~/.shellib/cdl
# curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/bash_conf/cdl.sh -o ~/.cdl

function cdl(){

	if [ -z "$1" ]; then
	  	dir="$HOME"
  	elif echo "$1" | grep -q '^/'; then  # bug: grep不能操作目录，这里$1是目录
  		dir="$1"
	else
		dir="$PWD/$1"
	fi


	if [ -d "$dir" ]; then
		cd "$dir" && ls -lah "$dir"
	elif [ -e "$dir" ]; then
		echo "$dir不是目录"
	else
		echo "当前路径下不存在$dir"
	fi  	
}

# 不作为命令，仅作为库文件，被主shell载入：source ~/.shellib/cdl
# cdl "$*"

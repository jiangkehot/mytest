#! /bin/bash

#遍历当前目录下的所有文件，并返回文件的绝对路径
myfunction(){

	if [[ -z "$1" ]]; then
		path="$PWD"
	else	
		path="$path/$1"
	fi

	for name in $(ls "$path" ); do
		
		# 判断文件名是否包含要替换的内容，如果包含，则替换并重新赋值给变量name 
		if [[ $(echo "$name" | grep "$OLD_VPN_SERVER_IP") ]]; then
			newname=$(echo $name | sed "s/$OLD_VPN_SERVER_IP/$VPN_SERVER_IP/g")
			mv "$path/$name" "$path/$newname"
			name=$newname
		fi

		# 判断如果是文件，则y用正则去替换文件内容
		if [[ -f "$path/$name" ]]; then
			sed -i "s/$OLD_VPN_SERVER_IP/$VPN_SERVER_IP/g" "$path/$name"
		# 如果是目录，则递归调用函数，重复上面的步骤
		elif [[ -d "$path/$name" ]]; then
			myfunction "$name"
		fi
	done

	# 递归调用结束购，需要还原path变量
	path=$(dirname "$path")
}



read -p "输入VPN服务器IP:" VPN_SERVER_IP
OLD_VPN_SERVER_IP='47.90.240.147'
myfunction







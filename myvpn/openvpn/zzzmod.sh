#! /bin/bash

#遍历当前目录下的所有文件，并返回文件的绝对路径
myfunction(){

	if [[ -z "$1" ]]; then
		path="$PWD"
	else	
		path="$path/$1"
	fi

	for name in $(ls "$path" ); do
		if [[ -f "$path/$name" ]]; then
			sed -i "s/$OLD_VPN_SERVER_IP/$VPN_SERVER_IP/g" "$path/$name"
		elif [[ -d "$path/$name" ]]; then
			newname=$(echo $name | sed "s/$OLD_VPN_SERVER_IP/$VPN_SERVER_IP/g")
			mv "$name" "$newname"
			name=$newname
			myfunction "$name"
		fi
	done
	path=$(dirname "$path")
}



read -p "输入VPN服务器IP:" VPN_SERVER_IP
OLD_VPN_SERVER_IP='47.90.240.147'
myfunction







#! /bin/bash

#遍历当前目录下的所有文件，并返回文件的绝对路径
myfunction(){

	if [[ -z "$1" ]]; then
		path="$PWD"
	else	
		path="$path/$1"
	fi

	for i in $(ls "$path" ); do
		if [[ -f "$path/$i" ]]; then
			echo "$path/$i"
		elif [[ -d "$path/$i" ]]; then
			myfunction "$i"
		fi
	done
	path=$(dirname "$path")
}

myfunction
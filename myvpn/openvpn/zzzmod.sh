#! /bin/bash

# 如果没有输入IP，则提示输入
if [[ -z "$1" ]]; then
    read -p "输入VPN服务器IP:" VPN_SERVER_IP
else
    VPN_SERVER_IP="$1"
fi

# 判断是否有输入路径，如果为空，则路径为当前目录。
if [[ -z "$2" ]]; then
    path="$PWD"
# 如果有输入，须判断输入的路径是绝对路径还是相对路径。
# 若是相对路径，且当前在根目录下,则为/xxx，
elif [ -z `dirname "$2" | grep '^/'` ]; then  
    if [[ "$PWD" == '/' ]]; then  
        path="/$2"
# 否则为$PWD/xxx，
    else
        path="$PWD/$2"
    fi
# 若输入为绝对路径，则直接赋值
else        
    path=$2
fi  


#遍历当前目录下的所有文件，并返回文件的绝对路径
myfunction(){

        if [[ -z "$1" ]]; then
                path="$path"
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



OLD_VPN_SERVER_IP='11.11.111.222'
myfunction

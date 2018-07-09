#! /bin/bash
#


#当shell语句错误即停止，防止错误继续执行
set -e

#设置系统时间为CTS时间
sudo ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


Get_Dist_Pm()
{
    if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    echo $PM;
}


if [ `Get_Dist_Pm` = "yum" ]; then
    #备份系统yum源
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

    #下载阿里云yum源
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    #或者
    #wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

    #生成缓存
    yum makecache    
fi


if [ `$Get_Dist_Pm` = "apt" ]; then
    #statements
    #备份源 
    cp  /etc/apt/sources.list  /etc/apt/sources.list_bak

    #替换阿里云的源
    sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
fi


sudo `Get_Dist_Pm` update && sudo `Get_Dist_Pm` upgrade





####### 来自daocloud ######
# lsb_dist=''
# command_exists() {
#     command -v "$@" > /dev/null 2>&1
# }
# if command_exists lsb_release; then
#     lsb_dist="$(lsb_release -si)"
#     lsb_version="$(lsb_release -rs)"
# fi
# if [ -z "$lsb_dist" ] && [ -r /etc/lsb-release ]; then
#     lsb_dist="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
#     lsb_version="$(. /etc/lsb-release && echo "$DISTRIB_RELEASE")"
# fi
# if [ -z "$lsb_dist" ] && [ -r /etc/debian_version ]; then
#     lsb_dist='debian'
# fi
# if [ -z "$lsb_dist" ] && [ -r /etc/fedora-release ]; then
#     lsb_dist='fedora'
# fi
# if [ -z "$lsb_dist" ] && [ -r /etc/os-release ]; then
#     lsb_dist="$(. /etc/os-release && echo "$ID")"
# fi
# if [ -z "$lsb_dist" ] && [ -r /etc/centos-release ]; then
#     lsb_dist="$(cat /etc/*-release | head -n1 | cut -d " " -f1)"
# fi
# if [ -z "$lsb_dist" ] && [ -r /etc/redhat-release ]; then
#     lsb_dist="$(cat /etc/*-release | head -n1 | cut -d " " -f1)"
# fi
# lsb_dist="$(echo $lsb_dist | cut -d " " -f1)"

# echo $lsb_dist
# 
# 说明：以下sh -s 后面的内容是为变量$1传值 curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://a13e0e77.m.daocloud.io
####### end  #######


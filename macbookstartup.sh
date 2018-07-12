#! /bin/bash


#下载macbookstartup.sh  curl -O  https://raw.githubusercontent.com/jiangkehot/mytest/master/macbookstartup.sh  #curl -O 大写O，保留远程文件的文件名； -o filename  重命名须小写o做参数，后面跟文件名
#修改脚本，增加需要的程序 & 注释掉不需要的程序
#执行脚本 sh -x macbookstartup.sh
#或者，若不需要修改可执行 curl -fsSL  https://raw.githubusercontent.com/jiangkehot/mytest/master/macbookstartup.sh | sh -x

#Appstore: wechat/ Evernote/ MindNode/ QQ/
#Safari: /yinpin.sogou.com /Astrill /docker /VirtualBox /vagrant /

#sh -x
#install Hmoebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


brew install \
wget \
# git \
# python3 \ #注释掉的只能放在最后，不能放在换行符之间，否则会报错。

#cask_GUI
brew update && brew cask install \
google-chrome \
# adobe-photoshop-cs6 \
# alfred \
# launchrocket \

#coding tools
brew cask install \
macvim \
pycharm \
sublime-text \
sequel-pro \
# filezilla \


#配置vim
curl -fsSL https://j.mp/spf13-vim3 | sh -

#添加docker-machine补全功能的脚本
#curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/docker/dockerMachine/dockerMachineCompletion.sh| sh -x

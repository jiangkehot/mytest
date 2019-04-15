#! /bin/bash

#添加docker-machine补全功能的脚本


#当shell语句错误即停止，防止错误继续执行
set -e

# 安装脚本补全程序bash-completion
yum install bash-completion -y

# cd /etc/bash_completion.d/

# wget -P . 'https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-wrapper.bash'
# wget -P . 'https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash'
# wget -P . 'https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-prompt.bash'

scripts=( docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash )
for i in "${scripts[@]}"; do 
	sudo wget https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/${i} \
	-P /etc/bash_completion.d
done

if ! grep 'docker_machine_ps1' $HOME/.bashrc; then
	echo "PS1='[\u@\h \W\$(__docker_machine_ps1)]\\$ '" >> $HOME/.bashrc
fi

#最后从新打开一个bash，补全命令就生效了。

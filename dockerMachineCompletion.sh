#! /bin/bash

#添加docker-machine补全功能的脚本


#当shell语句错误即停止，防止错误继续执行
set -e

cd /etc/bash_completion.d/

wget -P . 'https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-prompt.bash'
wget -P . 'https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-wrapper.bash'
wget -P . 'https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash'

echo "PS1='[\u@\h \W\$(__docker_machine_ps1)]\\$ '" >> $HOME/.bashrc

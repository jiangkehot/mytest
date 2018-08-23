# 打开目录，并列出所有内容
alias cdl='cd $1 && ls -la --color=auto $!'

# （默认使用颜色）列出所有内容
ll='ls -la --color=auto'

#停止并清除所有容器
alias qcrq='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'

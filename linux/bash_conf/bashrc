#shell命令：curl -fsSL https://raw.githubusercontent.com/jiangkehot/mytest/master/linux/mybashrc.sh -o .mybashrc && sh -x .mybashrc

# 向.bash_profile添加执行文件的命令
sudo tee ~/.bash_profile <<-'EOF'
{
  if [ -f ~/.bashrc ]; then
	  . ~/.mybashrc
  fi
}
EOF

# 打开目录，并列出所有内容
alias cdl='cd $1 && ls -la --color=auto $!'

# （默认使用颜色）列出所有内容
ll='ls -la --color=auto'

#停止并清除所有容器
alias qcrq='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'

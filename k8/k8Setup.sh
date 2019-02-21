#! /bin/bash
# curl https://raw.githubusercontent.com/jiangkehot/mytest/master/k8/k8Setup.sh | sh -x

set -e

# # install kubelet / kubeadm / kubectl

# # Ubuntu, Debian or HypriotOS
# apt-get update && apt-get install -y apt-transport-https

# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
# deb http://apt.kubernetes.io/ kubernetes-xenial main
# EOF

# apt-get update && apt-get install -y kubelet kubeadm kubectl
# ###################


############################
# google CentOS(kubernetes.repo.google)
cat <<EOF > /etc/yum.repos.d/kubernetes.repo.google
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF
#############################



# CentOS, RHEL or Fedora
# # Aliyun CentOS
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
# sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

systemctl enable kubelet && systemctl start kubelet  


# Enabling shell autocompletion 脚本补全
yum install bash-completion -y
echo "source <(kubectl completion bash)" >> ~/.bashrc

# 初始化kube集群
# kubeadm init --apiserver-advertise-address=192.168.100.101 --pod-network-cidr=10.244.0.0/16

# 非root账户配置 kubectl
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 创建Pod网络
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

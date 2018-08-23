#! /bin/bash
# curl https://raw.githubusercontent.com/jiangkehot/mytest/master/k8/k8Setup.sh | sh -x

set -e

# install kubelet / kubeadm / kubectl
apt-get update && apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update && apt-get install -y kubelet kubeadm kubectl


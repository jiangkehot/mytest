#! /bin/bash


k8sRegistry="k8s.gcr.io"
localRegistry="localhost:5000"
aliyunRegistry="registry.cn-beijing.aliyuncs.com/univerdream_k8sgcrio"
# 经典网络
# registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio
# 专有网络
# registry-vpc.cn-beijing.aliyuncs.com/univerdream_k8sgcrio
sudo docker login --username=univerdream $aliyunRegistry

pushimages(){

}

function pushimages(){
	bfRegistry=$1
	afRegistry=$2

	# docker images --format "{{.Repository}}:{{.Tag}}"
	k8sImages=$(docker images | awk '{print $1":"$2}' | grep "$bfRegistry" | sed "s/$bfRegistry\///g")

	#push images
	for K8sImageName in $k8sImages; do
		docker tag $bfRegistry/$K8sImageName $afRegistry/$K8sImageName
		docker push $afRegistry/$K8sImageName
		docker rmi $afRegistry/$K8sImageName
	done

	for K8sImageName in $k8sImages; do
		echo "docker pull $afRegistry/$K8sImageName"
	done
}

#pull images
docker pull registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio/kube-proxy:v1.12.1
docker pull registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio/kube-apiserver:v1.12.1
docker pull registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio/kube-controller-manager:v1.12.1
docker pull registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio/kube-scheduler:v1.12.1
docker pull registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio/etcd:3.2.24
docker pull registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio/coredns:1.2.2
docker pull registry-internal.cn-beijing.aliyuncs.com/univerdream_k8sgcrio/pause:3.1
for K8sImageName in $k8sImages; do
		docker tag $bfRegistry/$K8sImageName $afRegistry/$K8sImageName
		docker rmi $bfRegistry/$K8sImageName
done

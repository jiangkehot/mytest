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

	k8sImages=$(docker images | awk '{print $1":"$2}' | grep "$bfRegistry" | sed "s/$bfRegistry\///g")

	#push images
	for K8sImageName in $k8sImages; do
		docker tag $bfRegistry/$K8sImageName $afRegistry/$K8sImageName
		docker push $afRegistry/$K8sImageName
		docker rmi $afRegistry/$K8sImageName
	done

	for imagesName in $k8sImages; do
		echo "docker pull $afRegistry/$K8sImageName"
	done
}

#pull images
for K8sImageName in $k8sImages; do
		docker tag $bfRegistry/$K8sImageName $afRegistry/$K8sImageName
		docker rmi $afRegistry/$K8sImageName
done

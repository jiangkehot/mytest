#! /bin/bash

K8S_GRCIO_REPOSITORYS=`docker images | awk '{print $1}' | grep 'k8s.gcr.io'`

#push images
for OLD_K8S_GRCIO_REPOSITORY in $K8S_GRCIO_REPOSITORYS; do
	NEW__K8S_GRCIO_REPOSITORY=`$OLD_K8S_GRCIO_REPOSITORY | sed -n 's/k8s.gcr.io/registry.cn-beijing.aliyuncs.com\/univerdream_k8sgcrio/g'p`
	docker tag $K8S_GRCIO_REPOSITORY $NEW__K8S_GRCIO_REPOSITORY
	docker push $NEW__K8S_GRCIO_REPOSITORY
done

#pull images
for OLD_K8S_GRCIO_REPOSITORY in $K8S_GRCIO_REPOSITORYS; do
	NEW__K8S_GRCIO_REPOSITORY=`$OLD_K8S_GRCIO_REPOSITORY | sed -n 's/k8s.gcr.io/registry.cn-beijing.aliyuncs.com\/univerdream_k8sgcrio/g'p`
	echo 'docker pull $NEW__K8S_GRCIO_REPOSITORY'
done

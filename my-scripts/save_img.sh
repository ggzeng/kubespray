#! /bin/bash
# ZengGanghui 2018.12.10

KUBE_VER="1-12-3"
FILTER="registry1"
REGISTRY="registry1:8000/kubespray-$KUBE_VER"

#docker images | sed '1d' | grep "$FILTER" | awk '{printf("%s:%s\n",$1,$2)}' | xargs -i docker push ${REGISTRY}/{}

images=`docker images | sed '1d' | grep -v "$FILTER" | awk '{printf("%s:%s\n",$1,$2)}'`
for image in ${images[@]};
do
    #echo "======== pull $image ========"
    #docker pull $image

    echo "======== push $image ========"
    docker tag $image ${REGISTRY}/$image
    docker push ${REGISTRY}/$image
    image_names="$image_names $image"
done


#echo "======== save ceph $VER images ========"
#docker save -o kolla_ceph_$VER.tar $image_names

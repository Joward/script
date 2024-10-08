#!/bin/bash

export WORKSPACE=${HOME}/workspace
export CONTAINER=tiddlywiki

cd ${WORKSPACE}/${CONTAINER}
pwd

docker stop ${CONTAINER}
sleep 2

rm -rf mywiki
sleep 2

git clone -b main ubuntu@192.168.5.55:/mnt/mmcblk1p1/gitweb/tidgi.git mywiki

docker run -d --rm \
--name=${CONTAINER} \
-p 5645:8080 \
-v ${WORKSPACE}/${CONTAINER}:/var/lib/tiddlywiki \
jbardi/tiddlywiki5-lazy-images

# nicolaw/tiddlywiki

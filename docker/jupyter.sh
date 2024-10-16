#!/bin/bash

export WORKSPACE=${HOME}/workspace
export CONTAINER=$(basename "$0" .sh)

# mkdir -p ${WORKSPACE}/${CONTAINER}
cd ${WORKSPACE}/${CONTAINER}
pwd

docker stop ${CONTAINER}
sleep 2

docker run -d --rm \
--name=${CONTAINER} \
-p 8888:8888 \
-v ${WORKSPACE}/${CONTAINER}/jovyan:/home/jovyan \
jupyter/base-notebook

sleep 12
docker logs ${CONTAINER}


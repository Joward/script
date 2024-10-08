#!/bin/bash

export WORKSPACE=${HOME}/workspace
export CONTAINER=$(basename "$0" .sh)

mkdir -p ${WORKSPACE}/${CONTAINER}
cd ${WORKSPACE}/${CONTAINER}
pwd

docker stop ${CONTAINER}
sleep 2

docker run -d --rm \
--name=${CONTAINER} \
-p 3036:5230 \
-v ${WORKSPACE}/${CONTAINER}/memos/:/var/opt/memos \
neosmemo/memos

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
-p 90:80 \
-v ${WORKSPACE}/${CONTAINER}/usr/html/tb_axi_svt_uvm_basic_sys:/usr/share/nginx/html \
nginx

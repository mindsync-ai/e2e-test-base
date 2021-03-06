#!/bin/bash


THIS_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
IMAGE_NAME=mindsync/e2e-test-base
PASSWD_FROM_STDIN=0

while :; do 
    case "${1}" in
        -h|--help)
            exit
            ;;
        -)
            PASSWD_FROM_STDIN=1
            ;;
        *)            
            break
    esac
    
    shift
done

TAG="${1:-0.0.3}"

set -eux

DOCKER_USERNAME=${DOCKER_USERNAME:-"mindsync"}

if [ "${PASSWD_FROM_STDIN}" -eq 0 ]; then
    docker login -u "${DOCKER_USERNAME}" docker.io
else
    read PASSWD
    echo ${PASSWD} | docker login -u "${DOCKER_USERNAME}" docker.io --password-stdin
fi

docker push ${IMAGE_NAME}:${TAG}

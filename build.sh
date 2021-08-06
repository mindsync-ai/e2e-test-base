#!/bin/bash

set -eux

THIS_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
IMAGE_NAME=mindsync/e2e-test-base
TAG="${1:-0.0.1}"

docker build -t ${IMAGE_NAME}:${TAG} .

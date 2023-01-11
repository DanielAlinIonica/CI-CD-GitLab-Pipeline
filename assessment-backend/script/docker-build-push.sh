#!/bin/sh

# Stop script on first error
set -e
########## LOAD CONFIG ##########

source $(dirname $0)/config.conf

########## START ##########

cd "$(dirname "$0")/.."

########## CONFIG ##########

DOCKER_IMAGE_TAG="ionicda001"
AWS_DOCKER_REGISTRY_URL="${AWS_DOCKER_REGISTRY}.dkr.ecr.${AWS_REGION}.amazonaws.com"
FULL_NAME="${AWS_DOCKER_REGISTRY_URL}/${AWS_DOCKER_REPO}:${DOCKER_IMAGE_TAG}"
LATEST="${AWS_DOCKER_REGISTRY_URL}/${AWS_DOCKER_REPO}:${DOCKER_IMAGE_TAG}"

########## LOGIN ##########

echo "Logging in to Docker registry..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_DOCKER_REGISTRY_URL

########## BUILD ##########

echo "Building Image '${FULL_NAME}'..."
docker build -t "${FULL_NAME}" .

########## TAG ##########

echo "Tagging Image..."
docker tag "${FULL_NAME}" "${LATEST}"

########## PUSH ##########

echo "Pushing image to Docker Hub"
docker push "${FULL_NAME}"
docker push "${LATEST}"

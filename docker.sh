#!/bin/bash
# docker build  --no-cache  --tag bdhwan/nginx-php7-psql-mysql-node:0.3.6 .
# docker build --no-cache --tag bdhwan/nginx-php7-psql-mysql-node:0.3.6 .
# docker push bdhwan/nginx-php7-psql-mysql-node:0.3.6

VERSION=${1:-0.3.10}
IMAGE_NAME="bdhwan/nginx-php7-psql-mysql-node"

echo "Building Docker image: ${IMAGE_NAME}:${VERSION}"
echo "Platforms: linux/amd64, linux/arm64"

# Build and push using Docker Buildx with cloud builder
docker buildx build --no-cache \
  --builder cloud-giftistar-giftistar-builder \
  --platform linux/amd64,linux/arm64 \
  --tag ${IMAGE_NAME}:${VERSION} \
  --push \
  .



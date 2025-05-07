#!/bin/bash
docker build  --no-cache  --tag bdhwan/nginx-php7-psql-mysql-node:0.3.6 .
docker build --tag bdhwan/nginx-php7-psql-mysql-node:0.3.6 .
docker push bdhwan/nginx-php7-psql-mysql-node:0.3.6
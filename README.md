# nginx-php7-psql
우분투 16.04

설치항목
mysql-client, git, php7.0, php7.0-curl, php7.0-mbstring, nginx postgresql-client php php7.0-fpm php7.0-pgsql php7.0-mysql php7.0-gd php7.0-xml php7.0-intl phpunit 


start.sh 파일이 있을 경우 시작 시 실행됨 


/data 폴더에 persistent 데이터가 저장됨
version: '3.5'
services:
  php-service:
    hostname: 'php-service-hostname'
    image: bdhwan/nginx-php7-psql:0.2.5
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "10MB"
        max-file: "10"
    environment:
    - GIT_URL=git_url
    - DOCKER_MASTER_HOST=php_param 
    volumes:
    - /data/somefolder:/data
    - /etc/localtime:/etc/localtime:ro      
    ports:
    - "7001:80"



docker run -ti --rm -v $(pwd):/var/www/html -p 8888:80 bdhwan/nginx-php7-psql-mysql-node:0.3.3

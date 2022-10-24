#!/bin/bash    
ENV_LIST=$(printenv)
TARGET_FILE=/etc/php/7.0/fpm/pool.d/www.conf
echo "" >> $TARGET_FILE
while read -r line
do 
  IFS='=' read -a strarr <<< "$line"
  if  [[ ${strarr[0]} == DOCKER_* ]];
  then
    echo "left ="${strarr[0]}
    echo "right ="${strarr[1]} 
    echo "env[${strarr[0]}] = ${strarr[1]};" >> $TARGET_FILE
  fi
done <<<"$ENV_LIST"
#!/bin/bash
echo "ok"
echo "GIT_URL: "$GIT_URL
echo "BRANCH: "$BRANCH
echo "DST_FOLDER: "$DST_FOLDER


if [ -z "$GIT_URL" ]
then
    echo "not defined GIT_URL"
else 
    git clone --depth 1 --single-branch --branch ${BRANCH} "$GIT_URL"
    rm -rf /var/www/html
    if [ -z "$DST_FOLDER" ]
    then
        echo "not defined DST_FOLDER"
        mv "$(basename "$GIT_URL" .git)" /var/www/html
    else 
        echo "defined =" $DST_FOLDER
        cd "$(basename "$GIT_URL" .git)"
        mv $DST_FOLDER /var/www/html
    fi
fi

CRON_FILE=/var/www/html/crontab/mk_crontab
if test -f "$CRON_FILE"; then
    echo "$CRON_FILE exist"
    cp $CRON_FILE /etc/cron.d/mk_crontab
    chmod 0644 /etc/cron.d/mk_crontab
    crontab /etc/cron.d/mk_crontab
    touch /var/www/html/crontab/log/cron.log
    service cron restart
    echo "done init crontab"
    crontab -l
else    
    echo "$CRON_FILE does not exist"    
fi


FILE=/var/www/html/start.sh
if test -f "$FILE"; then
    echo "$FILE exist"
    cd /var/www/html
    sh start.sh
fi




echo 'done init check process'






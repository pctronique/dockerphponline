#!/bin/bash

if [ -z ${PHP_FOLDER_LOG} ]
then
    PHP_FOLDER_LOG="/var/log/docker/php/"
fi

if [ -z ${PHP_FOLDER_INIT} ]
then
    PHP_FOLDER_INIT="/var/docker/php/"
fi

${PHP_FOLDER_INIT}importdata.sh 2>> ${PHP_FOLDER_LOG}installdata.log

crontab /etc/cron.d/dockercron

touch ${PHP_FOLDER_LOG}cron.log
cron && tail -f ${PHP_FOLDER_LOG}cron.log &

exec "$@"
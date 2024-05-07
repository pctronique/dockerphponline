#!/bin/bash

/var/docker/php/importdata.sh 2>> /var/log/docker/php/installdata.log

cron 2&>> /var/log/docker/php/cron.log

exec "$@"
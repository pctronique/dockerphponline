#!/bin/bash
while read line  
do   
    line="$line" | xargs
    if [[ ! $line =~ ^# ]];
    then
        if [ ! -z "$line" ]
        then
            value=${line#*=}
            name=${line%=*}
            export $name="$value"
        fi
    fi
done < /var/docker/php/.env

if [ -d "/var/docker/php/data" ]; then
    if [ ! -d "/usr/local/apache2/www/$FOLDER_DATA" ]; then
        mkdir -p "/usr/local/apache2/www/$FOLDER_DATA"
        cp -r /var/docker/php/data/* "/usr/local/apache2/www/$FOLDER_DATA/"
    fi
fi

exit 0

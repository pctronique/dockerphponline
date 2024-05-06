#!/bin/bash

echo "0010" >> "/var/log/docker/php/importall.log"
echo "0010" >> "/tmp/importall.log"

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

if [ -f "${0%/*}/installdata.txt" ]
then
    exit 0
fi

if [ ! -d "/usr/local/apache2/www/$FOLDER_DATA" ]; then
  mkdir -p "/usr/local/apache2/www/$FOLDER_DATA"
  cp -r /var/docker/php/data/* "/usr/local/apache2/www/$FOLDER_DATA/"
fi

echo "data:true" >> "${0%/*}/installdata.txt"

exit 0

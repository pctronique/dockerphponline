#!/bin/bash

echo "0001" >> "/var/log/docker/php/importall.log"
echo "0001" >> "/tmp/importall.log"

while [ ! -f /var/docker/php/.env ]
do
  sleep 0.2
done
echo "0002" >> "/var/log/docker/php/importall.log"
echo "0002" >> "/tmp/importall.log"

while [ ! -d /var/docker/php/data ]
do
  sleep 0.2
done
echo "0003" >> "/var/log/docker/php/importall.log"
echo "0003" >> "/tmp/importall.log"

/mongo-seed/import.sh 2>> "/var/log/docker/php/importall.log"

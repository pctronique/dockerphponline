while read line  
do   
   export $line
done < ${0%/*}/../.env
docker exec -it $NAME_PROJECT"_php" php /opt/phpDocumentor/vendor/bin/phpdoc "$@"

# creation des tmp du docker
mkdir -p .dockertmp/mariadb_data
mkdir -p .dockertmp/tmp
mkdir -p .dockertmp/tmp/php
mkdir -p .dockertmp/tmp/mariadb
mkdir -p .dockertmp/tmp/httpd
mkdir -p .dockertmp/log
mkdir -p .dockertmp/log/php
mkdir -p .dockertmp/log/httpd
mkdir -p .dockertmp/log/xdebug
mkdir -p .dockertmp/log/mariadb

# modifier les droits sur les dossiers
chmod 777 -R .dockertmp

# creation du fichier .env
if [ -e .env ]
then
    echo ""
else
    echo ""
    cp .env.example .env
fi

# creation du docker du projet
docker compose up -d

# dockerphponline
Par [pctronique](https://pctronique.fr/) <br />
Version 1.0.0

<details>
  <summary>Table des matières</summary>
  <ol>
    <li>
        <a href="#Installation">Installation</a>
    </li>
    <li>
        <a href="#Autres-informations">Autres informations</a>
        <ul>
            <li><a href="#Versions">Versions</a></li>
            <li><a href="#Config">Config</a></li>
            <ul>
                <li><a href="#Configurations-du-SGBD-du-site">Configurations SGBD du site</a></li>
                <li><a href="#php.ini-et-httpd.conf">php.ini et httpd.conf</a></li>
                <li><a href="#Xdebug">Xdebug</a></li>
            </ul>
            <li><a href="#Les-données-de-la-base-de-données">Les données de la base de données</a></li>
            <li><a href="#Bin-et-install.sh">Bin et install.sh</a></li>
        </ul>
    </li>
  </ol>
</details>

## Installation :

Vous devez avoir installé [docker-desktop](https://www.docker.com/products/docker-desktop/) sur votre système d'exploitation avant de pouvoir utiliser ce code.

Modifier le nom du projet dans le fichier « .env.example » :
```
NAME_PROJECT=projectphp
```
Mettre le nom du projet.

> [!WARNING]
> En modifiant le nom du projet, il faudra aussi le modifier dans le fichier « config/config_sgbd.php », pour pouvoir se connecter au serveur de la base de données :
> ```
> $name_project = "projectphp";
> ```

Sur un terminal (pour créer le fichier « .env ») :
```
$ cp .env.example .env
```
Possible de modifier les ports dans le fichier « .env » (il est préférable de conserver les ports par défaut dans l’exemple).
```
VALUE_HTTPD_PORT=80
VALUE_PHPMYADMIN_PORT=8080
VALUE_MAILHOG_DISPLAY_PORT=8020
```

> [!NOTE]
> => 0 pour le projet 0
> 
> => 1 pour le projet 1
> ```
> VALUE_HTTPD_PORT=81
> VALUE_PHPMYADMIN_PORT=8081
> VALUE_MAILHOG_DISPLAY_PORT=8021
> ```

Création des conteneurs :
```
$ docker compose up -d
```

Le code devra être placé dans le dossier « www ».

## Autres informations

### Versions

> [!WARNING]
> Le faire avant de créer le fichier « .env ».

Il est possible de modifier les versions des conteneurs dans le fichier « .env.example ».
```
VALUE_HTTPD_VERSION=2.4.59
VALUE_MARIABD_VERSION=10.4.18-focal
VALUE_MAILHOG_VERSION=v1.0.0
```
 
pour modifier la version du php c’est dans le fichier « .docker/php/Dockerfile » :
```
FROM php:8.3.7RC1-fpm
```

> [!NOTE]
> Prendre une version fpm pour php.

### Config

#### Configurations du SGBD du site
Les modifications de configuration de la base de données devront être effectuées dans le fichier « config/config_sgbd.php ».

> [!WARNING]
> Ne surtout pas faire les modifications dans le fichier « www/config/config_sgbd.php ».

#### php.ini et httpd.conf
<ul>
  <li>Le fichier « php.ini » se trouve dans « .docker/php/ ».</li>
  <li>Le fichier « httpd.conf » se trouve dans « .docker/apache/ ».</li>
</ul>

#### Xdebug
Il utilise xdebug et il est déjà configuré, mais il est possible de modifier la configuration dans le fichier « .docker/php/xdebug.ini »

### Les données de la base de données

Le dossier « .dockertmp/mariadb_data/ » va contenir la base de données, ceci permet de ne pas perdre la base de données quand on supprime le conteneur (si on veut supprimer la base de données, il faut supprimer le conteneur de celui-ci et ce dossier).

> [!WARNING]
> Le dossier « .dockertmp » ne doit pas être mis sur le github, c’est un dossier temporaire. 

Celui-ci installera une base de données (« project ») vide par défaut (possible de le retirer dans le fichier « docker-compose.yml »).
```
# start sql
- ./config/0001_project.sql:/docker-entrypoint-initdb.d/0001_project.sql
# stop sql
```

### Pour Linux

Si vous avez installé [docker engine](https://docs.docker.com/engine/install/), vous pouvez accéder au terminal de vos conteneurs à partir du dossier « bin ».
Avec [docker engine](https://docs.docker.com/engine/install/), il est possible d'avoir un problème de droit pour accéder au dossier de la base de données par docker, il sera préférable de faire :
```
$ ./install.sh
```

> [!NOTE]
> Il va créer les dossiers avant de construire le conteneur.

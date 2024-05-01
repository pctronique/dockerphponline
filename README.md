# dockerphponlinePar [pctronique](https://pctronique.fr/) <br />
Version 1.0.0

<details>
  <summary>Table des matières</summary>
  <ol>
    <li>
        <a href="#Installation">Installation</a>
    </li>
    <li>
        <a href="#Autres informations"># Autres informations</a>
        <ul>
            <li><a href="#Versions">Versions</a></li>
            <li><a href="#Config">Config</a></li>
            <li><a href="#Données-de-la-base-de-données">Données de la base de données</a></li>
            <li><a href="#Bin-et-install.sh">Bin et install.sh</a></li>
        </ul>
    </li>
  </ol>
</details>

## Installation :

Vous devez avoir installé <a href="https://www.docker.com/products/docker-desktop/" target="_blank">docker-desktop</a> sur votre système d'exploitation avant de pouvoir utiliser ce code.

Modifier le nom du projet dans le fichier « .env.example » :
```
NAME_PROJECT=projectphp
```
Mettre le nom du projet.

> [!WARNING]
> En modifient le nom du projet, il faudra aussi modifier le modifier dans le fichier « config/config_sgbd.php », pour pouvoir se connecter au serveur de la base de donnée :
> ```
> $name_project = "projectphp";
> ```

Sur un terminal (pour créer le fichier « .env ») :
```
$ cp .env.example .env
```
Posible de modifier les ports dans le fichier « .env » (il est préférable de conserver les ports par défaut dans l’exemple).
```
VALUE_HTTPD_PORT=80
VALUE_PHPMYADMIN_PORT=8080
VALUE_MAILHOG_DISPLAY_PORT=8020
```

> [!NOTE]
> => 0 pour le projet 0
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

Le code devra être placé dans le dossier « www »

## Autres informations

### Versions

Possible aussi de modifier les versions dans le fichier « .env.example », le faire avant de créer le fichier « .env ».
```
VALUE_HTTPD_VERSION=2.4.59
VALUE_MARIABD_VERSION=10.4.18-focal
VALUE_MAILHOG_VERSION=v1.0.0
```
 
pour modifier la version du php c’est dans le fichier « .docker/php/Dockerfile » :
```
FROM php:8.3.7RC1-fpm
```
(prendre une version fpm)

### Config

Il utilise xdebug et déjàs configuré, mais il est possible de modifier la configuration dans le fichier « .docker/php/xdebug.ini »

Le fichier « php.ini » se trouve dans « .docker/php/ ».
Le fichier « httpd.conf » se trouve dans « .docker/apache/ ».
Pour faire une configuration personnalisé.

Les modifications de configuration de la base de données devra être fait dans le fichier « config/config_sgbd.php », surtout pas dans « www/config/config_sgbd.php ».

### Données de la base de données

Le dossier « .dockertmp/mariadb_data/ » va contenir la base de données, ceci permet de ne pas perdre la base de données quand on supprime le conteneur (si on veut supprimer la base de donner, il faut supprimer le conteneur de celui-ci et ce dossier).
Le dossier « .dockertmp » ne doit pas être mis sur le github, c’est un dossier temporaire. 

Il installe une base de données « project » vide par défaut (possible de le retirer dans le fichier « docker-compose.yml »).
```
# start sql
- ./config/0001_project.sql:/docker-entrypoint-initdb.d/0001_project.sql
# stop sql
```

### Bin et install.sh

(le dossier « bin » c’est seulement pour linux, pas besoin sur windows et le fichier « install.sh », c’est en cas de problème de base de données sur linux, sur les droit d’accès au dossier de la base de données.)
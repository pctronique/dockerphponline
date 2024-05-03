# dockerphponline
Par [pctronique](https://pctronique.fr/) <br />
Version 1.1.0

<details>
  <summary>Table des matières</summary>
  <ol>
    <li><a href="#Présentation">Présentation</a></li>
    <li>
        <a href="#Installation">Installation</a>
        <ul>
            <li><a href="#Le-nom-du-projet">Le nom du projet</a></li>
            <li><a href="#Le-fichier-env">Le fichier .env</a></li>
            <li><a href="#Création-des-conteneurs">Création des conteneurs</a></li>
            <li><a href="#Où-placer-le-code">Où placer le code</a></li>
        </ul>
    </li>
    <li>
        <a href="#Autres-informations">Autres informations</a>
        <ul>
            <li><a href="#Versions">Versions</a></li>
            <li><a href="#Installer-la-dernière-version">Installer la dernière version</a></li>
            <li><a href="#Config">Config</a></li>
            <ul>
                <li><a href="#Configurations-du-SGBD-du-site">Configurations SGBD du site</a></li>
                <li><a href="#php.ini-et-httpd.conf">php.ini et httpd.conf</a></li>
                <li><a href="#Xdebug">Xdebug</a></li>
            </ul>
            <li><a href="#Les-données-de-la-base-de-données">Les données de la base de données</a></li>
            <li><a href="#Docker-engine">Docker engine</a></li>
        </ul>
    </li>
  </ol>
</details>

## Présentation

Pour créer un projet php avec docker.

Les versions :
<ul>
  <li>php:8.3.7RC1</li>
  <li>mariadb:10.4.18</li>
  <li>phpmyadmin:5.2.1</li>
  <li>apache:2.4.59</li>
  <li>Xdebug:3.3.2</li>
  <li>mailhog:v1.0.0</li>
  <li>composer:2.7.4</li>
</ul>

> [!NOTE]
> Ce code doit être mis dans votre projet git et devra être transmis sur le git (sans le fichier « README.md » pour pas écraser le vôtre).
> 
> Il fera partie du projet. Et le faire pour chaque projet php.

## Installation

Vous devez avoir installé [docker-desktop](https://www.docker.com/products/docker-desktop/) sur votre système d'exploitation avant de pouvoir utiliser ce code.

### Le nom du projet

Modifier le nom du projet dans le fichier « .env.example » :
```
NAME_PROJECT=projectphp
```
Mettre le nom du projet.

> [!WARNING]
> Le faire avant de créer le fichier « .env ».

### Le fichier .env

Sur un terminal (pour créer le fichier « .env ») :
```
$ cp .env.example .env
```

> [!NOTE]
> Si vous voulez envoyer le fichier « .env » sur le git, vous devrez modifier le fichier « .gitignore ». Mais je le déconseille fortement pour un travail de groupe.
> 
> Supprimer la ligne :
> ```
> /.env
> ```

> [!WARNING]
> Il est préférable de ne pas envoyer ce fichier sur le git, l'un des collègues du projet peut avoir un des ports déjà utilisé et devra le modifier. Ceci changera pour tout le groupe si vous l'avez mis sur le git.

Il est possible de modifier les ports dans le fichier « .env » (il est préférable de conserver les ports par défaut dans l’exemple).
```
VALUE_HTTPD_PORT=80
VALUE_PHPMYADMIN_PORT=8080
VALUE_MAILHOG_PORT=8020
```

> [!NOTE]
> Exemple :
> 
> Vous pouvez incrémenter les ports avec la technique suivante :
> 
> => 0 pour le projet 0
> 
> => 1 pour le projet 1
> ```
> VALUE_HTTPD_PORT=81
> VALUE_PHPMYADMIN_PORT=8081
> VALUE_MAILHOG_PORT=8021
> ```
> 
> => 2 pour le projet 2
> ```
> VALUE_HTTPD_PORT=82
> VALUE_PHPMYADMIN_PORT=8082
> VALUE_MAILHOG_PORT=8022
> ```

### Création des conteneurs

```
$ docker compose up -d
```
> [!WARNING]
> Vous avez besoin du fichier « .env », sinon vous allez avoir des erreurs.

### Où placer le code

Le code devra être placé dans le dossier « www ».

## Autres informations

### Versions

Pour que le projet soit toujours valide, il est préférable de mettre en place des versions fixes.

> [!WARNING]
> Le faire avant de créer le fichier « .env ».

Il est possible de modifier les versions des conteneurs dans le fichier « .env.example ».
```
VALUE_HTTPD_VERSION=2.4.59
VALUE_PHP_VERSION=8.3.7RC1-fpm
VALUE_COMPOSER_VERSION=2.7.4
VALUE_XDEBUG_VERSION=3.3.2
VALUE_MARIABD_VERSION=10.4.18-focal
VALUE_MAILHOG_VERSION=v1.0.0
VALUE_PHPMYADMIN_VERSION=5.2.1
```

> [!NOTE]
> Prendre une version fpm pour php.

> [!WARNING]
> En modifiant la version de xdebug, vous devrez aussi modifier le fichier « .docker/php/xdebug.ini » (no-debug-non-zts-20230831) :
> ```
> zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20230831/xdebug.so
> ```
> Pour modifier le fichier, il faudra créer le conteneur sans aucune modification et aller sur le terminal du php pour entrer la commande :
> ```
> $ ls /usr/local/lib/php/extensions/
> ```
> Vous obtiendrez la valeur à mettre dans le fichier. Redémarrer le conteneur php.

### Installer la dernière version
> [!WARNING]
> À utiliser une seule fois dans la création du projet et ensuite remettre la valeur des versions que vous aurez obtenue. Ne surtout pas conserver ce format dans un projet.

```
VALUE_HTTPD_VERSION=latest
VALUE_PHP_VERSION=fpm
VALUE_COMPOSER_VERSION=latest
VALUE_XDEBUG_VERSION=
VALUE_MARIABD_VERSION=focal
VALUE_MAILHOG_VERSION=latest
VALUE_PHPMYADMIN_VERSION=latest
```

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

Vous pouvez entrer une base de données par défaut du projet, il suffit d'exporter la base de données sous format sql et le placer dans le fichier « docker-compose.yml ».

Exemple :
Exporter la base de données dans le fichier « project_def.sql », le placer dans « config » et faire :
```
# start sql
- ./config/0001_project.sql:/docker-entrypoint-initdb.d/0001_project.sql
- ./config/project_def.sql:/docker-entrypoint-initdb.d/project_def.sql
# stop sql
```

> [!NOTE]
> Il est préférable d'entrer une base de données par défaut, pour pouvoir avoir un site directement opérationnel après l'installation des conteneurs et pouvoir directement repartir sur le code sans devoir tout reconfigurer. Quand on revient des années après sur le projet, on doit juste installer les conteneurs et on a directement le site sans aucune autre modification à faire, on peut directement coder.

### Docker engine

Si vous avez installé [docker engine](https://docs.docker.com/engine/install/), vous pouvez accéder au terminal de vos conteneurs à partir du dossier « bin ».

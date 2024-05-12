<?php

require __DIR__ . "/config_sgbd.php";

// creation de la ligne de connexion a placer dans le PDO
$configsgbd = $type . ':host=' . $server;
if(!empty($port) && $port !== "0") {
    $configsgbd .= ';port=' . $port;
}
$configsgbd .= ';dbname=' . $dbname;
$configsgbd .= ";charset=UTF8";

$sgbd = new PDO($configsgbd, $user, $pass);

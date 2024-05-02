<?php
if(!function_exists("load_file_env")) {
    function load_file_env(string $path):void
    {
        $lines = file($path . '/.env');
        foreach ($lines as $line) {
            if(!empty(trim($line))) {
                [$key, $value] = explode('=', $line, 2);
                $key = trim($key);
                $value = trim($value);
                $_ENV[$key] = $value;
            }
        }
    }
}

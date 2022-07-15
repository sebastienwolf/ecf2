<?php

class Database
{
    private static $instance = null;

    public static function getPdo(): PDO
    {
        // J'ai mis en place sur ma machine des variables d'environnements pour le faire. 
        // Pour l'ECF, je les ai transformés en variable normale pour l'ecf pour une correction.

        // $dbHost = getenv("CS_HOST");
        // $dbName = getenv("CS_DB_NAME");
        // $dbUser = getenv("CS_DB_USERNAME");
        // $dbPwd = getenv("CS_DB_PASSWORD");

        $dbHost = "localhost";
        $dbName = "comparator";
        $dbUser = "sebastien";
        $dbPwd = "sebastien";

        if (self::$instance === null) {
            self::$instance = $pdo = new PDO("mysql:host=$dbHost;dbname=$dbName;charset=utf8", "$dbUser", "$dbPwd", [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
            ]);
        }

        return self::$instance;
    }
}

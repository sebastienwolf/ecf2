<?php
class Application
{
    public static function process()
    {
        $controllerName = "Question";
        $task = "showForumulaire";

        if (!empty($_GET['controller'])) {
            // ucfirst met le premier caractere en majuscule
            $controllerName = ucfirst($_GET['controller']);
        }

        if (!empty($_GET['task'])) {
            $task = $_GET['task'];
        }

        $controllerName = "\Controllers\\" . $controllerName;
        $controller = new $controllerName();
        $controller->$task();
    }
}

<?php
require_once 'funky.php';
require_once 'chroot.php';
//require_once 'nginxdomain.php';


$first_timer = "Is it your first time applying chroot?";

$move_to_chroot = <<<EOD
<p>
Before you Start ensure you have the tumbleweed or any linux package you prefer.
Place this in the main stream directory where you would be creating chroot sites.
Proceed with the following
</p>
EOD;



$output = require_get('f');

switch ($output) {

    case "newChroot":
        $post = print_r($_POST,true);
        display_output($post);
        break;
    default:
        die("invalid f requested");
}




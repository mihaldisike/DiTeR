<?php

ini_set('scream.enabled', true);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$page = "new";

require_once 'layout/body.php';

echo <<<EOD
<div class="container">
$main_menu
$body
$welcome_layout
</div>
</div> 
EOD;
?>

<script>

</script>


 

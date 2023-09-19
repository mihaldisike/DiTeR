<?php
ini_set('scream.enabled', true);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'config.php';

/*
switch ($function) {
    case "new":
        welcome();
        break;

    case "phpversion":
        phpversion();
        break;

    case "nginxinsert":
        checkmail();
        break;
    default:
        die("invalid f requested");
}

function require_get(string $key) {

    if (isset($_REQUEST[$key])) {
        $value = $_REQUEST[$key];
    }
    if (empty($value)) {
        $error_message = <<<EOD
                {"error" : true, "message": "Inserisci $key","markRed": "$key" }
EOD;
        die($error_message);
    }
    return $value;
}


/*

function welcome() {
    
    
}

function phpversion_change() {
       
}

function nginxinsert() {
    
    
}
 * 
 */

function create_bash($file, $content) {
$file = fopen("newfile.sh", "w") or die("Unable to open file!");
$com_content = $content;
fwrite($myfile, $txt);
$txt = "Jane Doe\n";
fwrite($myfile, $txt);
fclose($myfile);
}

function display_output($content) {
    echo  $content;
}

function totalSites(){
    
    $sql = <<<EOD
SELECT COUNT(*)  as count FROM `sites`
EOD;
    $total_sites =db()->getLine($sql);
    // WHERE status = "active"
    //$total = mysqli_fetch_assoc($total_number);
    //var_dump($total_number);
    $total_number = $total_sites->count;
    //print($total_number);
    echo $total_number;
}

// Ports
function getLastUsedPort(){
    $portCheck = <<<EOD
    SELECT MAX(`port`) FROM `sites`
EOD;
    
    return db()->getLine($portCheck);
}

function getAfreePort (){
    $port = getLastUsedPort();
    do{
        $port++;
        $newfreePort = checkSocket($port);
    }while($newfreePort);
}


//socket function check
function checkSocket(int $port){
        
if(!function_exists("socket_create")){
    die("Critical Error You must have php-socket extension! \n");
}

if (!extension_loaded('sockets')) {
    die('The sockets extension is not loaded.');
}

// create for tcp
$sock = socket_create(AF_INET, SOCK_STREAM, getprotobyname('tcp'));
if (!$sock)
    die('Unable to create AF_INET socket');

$res = socket_bind($sock, '127.0.0.1',$port);
if(!$res){
    return false;
}
return true;

}

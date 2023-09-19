<?php
require_once 'menu.php';
require_once 'funky.php';
//require_once 'content.php';
$user = 'buddy';

//Welcome Page

$welcome_layout = <<<EOD
        $totalsites 
        $activesites 
        $emails
EOD;

$totalsites = <<<EOD
<div class="apply anim home-box" style="--delay: .7s">
                    <div class="video-by">First time?</div>
                    <div class="video-name">New configuration </div>
                </div>
EOD;

$activesites = <<<EOD
<div class="apply anim home-box" style="--delay: .7s">
                    <div class="video-by">First time?</div>
                    <div class="video-name">New configuration</div>
                </div>
EOD;

$emails = <<<EOD
<div class="apply anim home-box" style="--delay: .7s">
                    <div class="video-by">First time?</div>
                    <div class="video-name">New configuration</div>
                </div>
EOD;

// End Welcome Page

// Main Body
$body = <<<EOD
<div class="wrapper">
        <div class="header">
            <!--div class="search-bar">
                <input type="text" placeholder="Search">
            </div-->
            <div class="user-settings">
                <img class="user-img" src="https://images.unsplash.com/photo-1587918842454-870dbd18261a?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=943&q=80" alt="">
                <div class="user-name">Ciao $user!</div>
            </div>
        </div>
     <div class="main-container">
        <div class="main-header anim" style="--delay: 0s">DiTeR - Secure it the right way</div>
          <div class="small-header anim" style="--delay: .3s">Panorama </div>
        <div class="videos">
EOD;


?>

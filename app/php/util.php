<?php

require_once('./db-config.php');
date_default_timezone_set("Asia/Taipei");

function filter_escape ($str) {
  $str = htmlspecialchars($str);
  return mysql_real_escape_string($str); 
}


?>

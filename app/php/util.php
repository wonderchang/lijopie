<?php

require_once('./db-config.php');

function filter_escape ($str) {
  $str = htmlspecialchars($str);
  return mysql_real_escape_string($str); 
}


?>

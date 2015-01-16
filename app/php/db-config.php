<?php

require_once('./db-info.php');
$link = mysql_connect($host, $user, $pass) or die('Error with MySQL connection');
mysql_query("SET NAMES 'utf8'") or die('Error encoding');
mysql_select_db($name, $link) or die('Error with Database selection');

?>

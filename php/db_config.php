<?php
$file = fopen("../db", "r");
$db_host = trim(fgets($file));
$db_user = trim(fgets($file));
$db_pass = trim(fgets($file));
$db_name = trim(fgets($file));
fclose($file);
$db_link = mysql_connect($db_host, $db_user, $db_pass) or die('Error with MySQL connection');
mysql_query("SET NAMES 'utf8'") or die('Error with Database selsction');
mysql_select_db($db_name, $db_link) or die('Error with Database selection');
?>

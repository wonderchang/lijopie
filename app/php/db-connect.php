<?php

require_once('./config.php');
$link = mysql_connect($db_host, $db_user, $db_pass) or die('Error with MySQL connection');
mysql_query("SET NAMES 'utf8'") or die('Error encoding');
mysql_select_db($db_name, $link) or die('Error with Database selection');

?>

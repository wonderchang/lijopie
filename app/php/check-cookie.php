<?php

require_once('./db-config.php');
require_once('./util.php');

$cookie = filter_escape($_POST['cookie']);

$result = mysql_query("SELECT * FROM user WHERE cookie='$cookie'");
$num = mysql_num_rows($result);
if($num === 0) { echo 0; }
else if($num === 1) { echo 1; }
else { echo 2; }

?>

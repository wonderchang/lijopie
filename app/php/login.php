<?php
require_once('./db-connect.php');
require_once('./util.php');

$username = filter_escape($_POST['username']);
$password = filter_escape($_POST['password']);
$result = mysql_query("SELECT * FROM user WHERE username='$username'");
$num = mysql_num_rows($result);
switch($num) {
  case 0:
    echo 0; break;
  case 1:
    $row = mysql_fetch_assoc($result);
    $password = hash('sha256', $row['salt'].$password);
    if($password === $row['password'])
      echo $row['cookie'];
    else
      echo 2;
    break;
  default:
    echo 1; break;
}
?>

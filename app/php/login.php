<?php
require_once('./db-config.php');
require_once('./util.php');

$username = filter_escape($_POST['username']);
$password = filter_escape($_POST['password']);
$result = mysql_query("SELECT * FROM user WHERE username='$username'");
$num = mysql_num_rows($result);
if($num === 0) {
  echo 0;
}
else if($num === 1) {
  $row = mysql_fetch_assoc($result);
  $password = hash('sha256', $row['salt'].$password);
  if($password === $row['password']) {
    echo $row['cookie'];
  }
  else { echo 2; }
}
else {
  echo 1;
}
?>

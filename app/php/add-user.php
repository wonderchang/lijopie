<?php
require_once('./db-config.php');
require_once('./util.php');

$name = filter_escape($_POST['name']);
$gender = filter_escape($_POST['gender']);
$email = filter_escape($_POST['email']);
$username = filter_escape($_POST['username']);
$password = filter_escape($_POST['password']);

$r_mail = mysql_query("SELECT * FROM user WHERE email='$email'");
$r_user = mysql_query("SELECT * FROM user WHERE username='$username'");
$mail_num = mysql_num_rows($r_mail);
$user_num = mysql_num_rows($r_user);

if($mail_num > 0 && $user_num > 0) { echo 4; return; }
else if($mail_num === 0 && $user_num > 0 ) { echo 3; return; }
else if($mail_num > 0 && $user_num === 0 ) { echo 2; return; }
else if($mail_num === 0 && $user_num === 0) {
  $salt = md5(uniqid(rand(), true));
  $password = hash('sha256', $salt.$password);
  $cookie = md5($email.time().$salt);
  $insert = mysql_query("INSERT INTO user SET
    name='$name', username='$username', gender='$gender',
    email='$email', password='$password', salt='$salt',
    cookie='$cookie', createtime=now()");
  if($insert) { echo 1; }
  else { echo 0; }
}
else { echo 0; }

?>

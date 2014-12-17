<?php
require_once("db_config.php");

$username = $_POST["username"];
$password = $_POST["password"];
$name = $_POST["name"];
$gender = $_POST["gender"];
$email = $_POST["email"];
$phone = $_POST["phone"];
$address = $_POST["address"];
$salt = md5(uniqid(rand(), true));
$password = hash('sha256', $salt.$password);

$sql = "INSERT INTO user SET
	id=0,
	username='$username',
	password='$password',
	name='$name',
	gender=$gender,
	email='$email',
	phone='$phone',
	address='$address',
	salt='$salt',
	time=now()
	";

$result = mysql_query($sql);

if($result) {
	echo 1;
}
else {
	echo 0;
}
?>

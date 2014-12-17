<?php
require('db_config.php');

$username = $_POST['username'];
$password = $_POST['password'];

$result = mysql_query("SELECT * FROM user WHERE
	username='$username'
	");
$num = mysql_num_rows($result);

if($num == 0) {
	echo 0;
}
else if($num == 1) {
	$row = mysql_fetch_assoc($result);
	$salt = $row['salt'];
	$password = hash('sha256', $salt.$password);
	if($password == $row['password']) {
		echo 1;
	}
	else {
		echo 0;
	}
}
else {
	echo 2;
}
?>

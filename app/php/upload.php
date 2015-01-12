<?php

$tmp_file_name = $_FILES['Filedata']['tmp_name'];
echo $_FILES['Filedata']['name'];
echo "/";
echo $_FILES['Filedata']['size'];
echo "/";
echo $_FILES['Filedata']['type']:
$result = move_uploaded_file($tmp_file_name, '../upload/aaa.png');

?>

<?php
date_default_timezone_set("Asia/Taipei");
if (isset($_FILES['photo'])) {
  $size = $_FILES['photo']['size'];
  list($type, $ext) = explode("/", $_FILES['photo']['type']);
  $name = md5(uniqid(rand(), true).$_FILES['photo']['name']).'.'.$ext;
  move_uploaded_file($_FILES['photo']['tmp_name'], "../uploads/$name");
  $time = date('Y-m-d H:i:s');
  $cmd = "convert ../uploads/$name -channel RGBA -fill orange -stroke black -gravity SouthEast -pointsize 64 -annotate +10+5 '$time' ../uploads/$name";
  exec($cmd);
  echo $name;
}
else {
  echo 0;
}
?>

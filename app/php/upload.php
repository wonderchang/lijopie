<?php
if (isset($_FILES['photo'])) {
  $size = $_FILES['photo']['size'];
  list($type, $ext) = explode("/", $_FILES['photo']['type']);
  $name = md5(uniqid(rand(), true).$_FILES['photo']['name']).'.'.$ext;
  move_uploaded_file($_FILES['photo']['tmp_name'], "../uploads/$name");
  echo $name;
}
else {
  echo 0;
}
?>

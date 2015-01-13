<?php
if (isset($_FILES['photo'])) {
  $name = $_FILES['photo']['name'];
  move_uploaded_file($_FILES['photo']['tmp_name'], "../uploads/$name");
  echo $name;
}
else {
  echo 0;
}
?>

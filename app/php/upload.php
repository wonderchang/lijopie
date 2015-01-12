<?php
if (isset($_FILES['photo'])) {
  move_uploaded_file($_FILES['photo']['tmp_name'], "../uploads/".$_FILES['photo']['name']);
  echo 1;
}
else {
  echo 0;
}
?>

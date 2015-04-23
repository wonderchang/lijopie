<?php
require_once('./db-config.php');
require_once('./util.php');

$region_id = filter_escape($_POST['region']);
$subject_id = filter_escape($_POST['subject']);
$content = filter_escape($_POST['content']);
$anonymous = filter_escape($_POST['anonymous']);
$cookie = filter_escape($_POST['cookie']);
$photo = filter_escape($_POST['photo']);

$result = mysql_query("SELECT id FROM user WHERE cookie='$cookie'"); 
$num = mysql_num_rows($result);
if($num === 1) {
  $row = mysql_fetch_assoc($result);
  $user_id = $row['id'];
  $photo = "uploads/$photo";
  $expect = date('Y-m-d', time() + 20 * 86400);
  $result = mysql_query("INSERT INTO report SET
    user_id=$user_id,
    region_id=$region_id,
    subject_id=$subject_id,
    content='$content',
    progress_id=0,
    picture='$photo',
    anonymous=$anonymous,
    expect='$expect',
    reporttime=now()
    ");  
  if($result) { echo 1; }
  else { echo 0; }
}
else {
  echo 0;
}
?>

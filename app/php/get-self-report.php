<?php
require_once('./db-config.php');
require_once('./util.php');

$cookie = filter_escape($_POST['cookie']);

$result = mysql_query("SELECT * FROM report
  JOIN user
  ON report.user_id=user.id
  WHERE cookie='$cookie'
  ORDER BY reporttime DESC
  ");
$list = array();
while($row = mysql_fetch_assoc($result)) {
  array_push($list, $row);
}
echo json_encode($list);
?>

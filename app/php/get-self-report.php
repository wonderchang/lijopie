<?php
require_once('./db-connect.php');
require_once('./util.php');

$cookie = filter_escape($_POST['cookie']);
$result = mysql_query("SELECT * FROM report
  JOIN user ON report.user_id=user.id
  JOIN region ON region.region_id=report.region_id
  JOIN subject ON subject.subject_id=report.subject_id
  WHERE cookie='$cookie'
  ORDER BY report_time DESC
  ");
$list = array();
while($row = mysql_fetch_assoc($result)) {
  array_push($list, $row);
}
echo json_encode($list);
?>

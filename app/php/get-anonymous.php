<?php
require_once('./db-config.php');
require_once('./util.php');

$result = mysql_query("SELECT * FROM report
  JOIN region ON region.region_id=report.region_id
  JOIN theme ON theme.theme_id=report.theme_id
  WHERE anonymous=1
  ORDER BY reporttime DESC
");
$list = array();
while($row = mysql_fetch_assoc($result)) {
  array_push($list, $row);
}
echo json_encode($list);
?>

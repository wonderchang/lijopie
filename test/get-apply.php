<?php

$fp = fopen('response.html', 'r');
$content = fread($fp, filesize("response.html"));
fclose($fp);

if(!preg_match("/.*HTTP\/1\.1 200 OK.*/", $content)) {
  echo 'not ok';
  return;
}

$pattern = "/.*案號<\/label><\/th>\s*<td align=\"left\" class=\"font09\">(\d+)<\/td>.*/";
if(!preg_match($pattern, $content, $match)) {
  echo 'not ok';
  return;
}
$case_id = $match[1];

$pattern = "/.*申辦時間<\/label><\/th>\s*<td align=\"left\" class=\"font09\">(\d\d\d\d-\d\d-\d\d).*?(\d\d:\d\d:\d\d)<\/td>.*/";
if(!preg_match($pattern, $content, $match)) {
  echo 'not ok';
  return;
}
$apply_time = $match[1].' '.$match[2];


?>

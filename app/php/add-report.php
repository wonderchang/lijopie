<?php
date_default_timezone_set("Asia/Taipei");
require_once('./db-config.php');
require_once('./util.php');

$region_id = filter_escape($_POST['region']);
$subject_id = filter_escape($_POST['subject']);
$content = filter_escape($_POST['content']);
$anonymous = filter_escape($_POST['anonymous']);
$cookie = filter_escape($_POST['cookie']);
$picture1 = filter_escape($_POST['picture1']);
$picture2 = filter_escape($_POST['picture2']);
$picture3 = filter_escape($_POST['picture3']);

$result = mysql_query("SELECT id FROM user WHERE cookie='$cookie'"); 
$num = mysql_num_rows($result);

if($num != 1) { return; }

$row = mysql_fetch_assoc($result);
$result = mysql_query("INSERT INTO report SET
  user_id={$row['id']},
  region_id=$region_id,
  subject_id=$subject_id,
  content='$content',
  progress_id=0,
  picture1='$picture1',
  picture2='$picture2',
  picture3='$picture3',
  anonymous=$anonymous,
  report_time=now()
  ");

if(!$result) { echo 2; return; }

echo 1;
/*
$data = array(
  'nfile1'   => '@'.realpath("../$photo"),
  'nfile2'   => '',
  'nfile3'   => '',
  'name'     => 'lijopie',
  'sex'      => '2',
  'email'    => 'lijopie.tw@gmail.com',
  'tel'      => '請輸入電話',
  'job'      => '請輸入職業',
  'address'  => '請輸入地址',
  'subject'  => '彎道停車',
  'region'   => 'ou=01,ou=tncgb02,o=tncgb,c=tw',
  'content1' => '',
  'content'  => '車內無人，崇明路，文化派出所旁',
  'chkint'   => '81233'
);

$url = 'http://www.tnpd.gov.tw/chinese/home.jsp?menudata=TncgbMenu&mserno=201012130066&serno=201012130069&serno3=&serno4=&contlink=ap/mail1_save_new.jsp';
$user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36";
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_USERAGENT, $user_agent);
curl_setopt($ch, CURLOPT_HEADER, 1);
curl_setopt($ch, CURLOPT_COOKIE, 'JSESSIONID=aevmgy424i7b');
$result = curl_exec($ch);
$fp = fopen("$cookie-{$time()}.html");
var_dump($result);
curl_close($ch);
 */
?>

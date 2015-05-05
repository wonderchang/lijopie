<?php
date_default_timezone_set("Asia/Taipei");
require_once("./vendor/autoload.php");
require_once('./db-connect.php');
require_once('./util.php');

$subject_id = filter_escape($_POST['subject']);
$address    = filter_escape($_POST['address']);
$region_id  = filter_escape($_POST['region']);
$content    = filter_escape($_POST['content']);
$anonymous  = filter_escape($_POST['anonymous']);
$cookie     = filter_escape($_POST['cookie']);
$marker     = filter_escape($_POST['marker']);
$gps        = filter_escape($_POST['gps']);
$picture1   = filter_escape($_POST['picture1']);
$picture2   = filter_escape($_POST['picture2']);
$picture3   = filter_escape($_POST['picture3']);

$result = mysql_query("SELECT id FROM user WHERE cookie='$cookie'"); 
$num = mysql_num_rows($result);

if($num != 1) { echo 2; return; }

$row = mysql_fetch_assoc($result);
$user_id = $row['id'];
$content = $address.', '.$content;
$result = mysql_query("INSERT INTO report SET
  user_id=$user_id,
  region_id=$region_id,
  subject_id=$subject_id,
  content='$content',
  address='$address',
  marker='$marker',
  gps='$gps',
  progress_id=0,
  picture1='$picture1',
  picture2='$picture2',
  picture3='$picture3',
  anonymous=$anonymous,
  report_time=now()
  ");

if(!$result) { echo 2; return; }

$result = mysql_query("SELECT * FROM region WHERE region_id=$region_id");
$row = mysql_fetch_assoc($result);
$police_code = $row['police_code'];

$result = mysql_query("SELECT * FROM subject WHERE subject_id=$subject_id");
$row = mysql_fetch_assoc($result);
$subject_name = $row['subject_name'];

$result = mysql_query("SELECT * FROM session ORDER BY session_id DESC LIMIT 1");
$row = mysql_fetch_assoc($result);
$verify_code = $row['verify_code'];
$session = $row['cookie_key'].'='.$row['cookie_value'];

$data = array(
  'nfile1'   => '',
  'nfile2'   => '',
  'nfile3'   => '',
  'name'     => $agency_name,
  'sex'      => '2',
  'email'    => $agency_gmail_user,
  'tel'      => '請輸入電話',
  'job'      => '請輸入職業',
  'address'  => '請輸入地址',
  'subject'  => $subject_name,
  'region'   => $police_code,
  'content1' => '',
  'content'  => $content,
  'chkint'   => $verify_code
);
if($picture1 !== '') { $data['nfile1'] = '@'.realpath("../$picture1"); }
if($picture2 !== '') { $data['nfile2'] = '@'.realpath("../$picture2"); }
if($picture3 !== '') { $data['nfile3'] = '@'.realpath("../$picture3"); }

if($test_mode) {
  
  $case_id = time();
  $date    = date('Y-m-d');
  $time    = date('H:i:s');

  $file = '../res/response-template.html';
  $fp = fopen($file, 'r');
  $response = fread($fp, filesize($file));
  fclose($fp);

  $response = str_replace('{{case_id}}', $case_id, $response);
  $response = str_replace('{{date}}', $date, $response);
  $response = str_replace('{{time}}', $time, $response);
  $response = str_replace('{{reporter}}', $agency_name, $response);
  $response = str_replace('{{reporter_email}}', $agency_gmail_user, $response);
  $response = str_replace('{{subject_name}}', $subject_name, $response);
  $response = str_replace('{{content}}', $content, $response);

  $file = '../res/mail-template.html';
  $fp = fopen($file, 'r');
  $body = fread($fp, filesize($file));
  fclose($fp);
  $body = str_replace('{{date}}', $date, $body);
  $body = str_replace('{{reporter}}', $agency_name, $body);
  $body = str_replace('{{case_id}}', $case_id, $body);
  $body = str_replace('{{mail}}', $agency_gmail_user, $body);
  $body = str_replace('{{subject_name}}', $subject_name, $body);
  $body = str_replace('{{content}}', $content, $body);

  $mail = new PHPMailer;
  $mail->isSMTP();
  $mail->Host = 'smtp.gmail.com';
  $mail->SMTPAuth = true;
  $mail->Username = $test_simulator_gmail_user;
  $mail->Password = $test_simulator_gmail_password;
  $mail->SMTPSecure = 'ssl';
  $mail->Port = 465;
	$mail->CharSet = "utf-8";
	$mail->Encoding = "base64"; 

  $mail->From = $agency_gmail_user;
  $mail->FromName = '[測試] police';
  $mail->addAddress($agency_gmail_user);

  $mail->isHTML(true);
  $mail->Subject = '[測試] 臺南市政府警察局-違規舉發';
  $mail->Body    = $body;
  $mail->send();
}
else {
  $user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36";
  $url = 'http://www.tnpd.gov.tw/chinese/home.jsp?menudata=TncgbMenu&mserno=201012130066&serno=201012130069&serno3=&serno4=&contlink=ap/mail1_save_new.jsp';
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_POST, 1);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
  curl_setopt($ch, CURLOPT_USERAGENT, $user_agent);
  curl_setopt($ch, CURLOPT_HEADER, 1);
  curl_setopt($ch, CURLOPT_COOKIE, $session);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  $response = curl_exec($ch);
  curl_close($ch);
}
$response_file = "../response/$cookie-".time().'.html';
$fp = fopen($response_file, 'w');
fwrite($fp, $response);
fclose($fp);

if(!preg_match("/.*HTTP\/1\.1 200 OK.*/", $response)) { echo 0; return; }

$pattern = "/.*案號<\/label><\/th>\s*<td align=\"left\" class=\"font09\">(\d+)<\/td>.*/";
if(!preg_match($pattern, $response, $match)) { echo 0; return; }
$case_id = $match[1];

$pattern = "/.*申辦時間<\/label><\/th>\s*<td align=\"left\" class=\"font09\">(\d\d\d\d-\d\d-\d\d).*?(\d\d:\d\d:\d\d)<\/td>.*/";
if(!preg_match($pattern, $response, $match)) { echo 0; return; }
$apply_time = $match[1].' '.$match[2];

$result = mysql_query("UPDATE report SET
  response_file='$response_file',
  apply_time='$apply_time',
  case_id='$case_id'
  WHERE
  user_id=$user_id AND
  region_id=$region_id AND
  subject_id=$subject_id AND
  content='$content' AND
  address='$address' AND
  gps='$gps' AND
  marker='$marker' AND
  picture1='$picture1' AND
  picture2='$picture2' AND
  picture3='$picture3' AND
  anonymous=$anonymous
  ");

if(!$result) { echo 0; return; }

echo 1;
?>

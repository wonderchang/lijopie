<?php
$data = array(
  'nfile1'   => '@'.realpath('c94ab6b4708dcefa9b154134bb4a4e11.jpeg'),
  'nfile2'   => '',
  'nfile3'   => '',
  'name'     => 'lijopie',
  'sex'      => '1',
  'email'    => 'lijopie.tw@gmail.com',
  'tel'      => '請輸入電話',
  'job'      => '請輸入職業',
  'address'  => '請輸入地址',
  'subject'  => '彎道停車',
  'region'   => 'ou=01,ou=tncgb02,o=tncgb,c=tw',
  'content1' => '',
  'content'  => '車內無人 崇明路，文化派出所旁',
  'chkint'   => '81233'
);
$url = 'http://www.tnpd.gov.tw/chinese/home.jsp?menudata=TncgbMenu&mserno=201012130066&serno=201012130069&serno3=&serno4=&contlink=ap/mail1_save_new.jsp';
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36");
curl_setopt($ch, CURLOPT_HEADER, 1);
curl_setopt($ch, CURLOPT_COOKIE, 'JSESSIONID=aevmgy424i7b');
$result = curl_exec($ch);
var_dump($result);
curl_close($ch);
?>


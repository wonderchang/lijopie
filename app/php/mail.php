<?php
	/*	
		use PHPMailer-ML_v1.7.1_core version
	*/
	require_once("./class.phpmailer.php");
	require_once("./db-connect.php");
	require_once("./config.php");
	require_once('./util.php');
	date_default_timezone_set("Asia/Taipei");

	$subject = filter_escape($_POST['subject']);
	$sendername = filter_escape($_POST['name']);
	$from = filter_escape($_POST['from']);
	$content = $_POST['content'];
	$filted_content = filter_escape($content);

	$mail= new PHPMailer();
	$mail->IsSMTP();
	$mail->SMTPAuth = TRUE;
	$mail->SMTPSecure = "ssl";
	$mail->Host = "smtp.gmail.com";
	$mail->Port = 465;
	$mail->CharSet = "utf-8";
	$mail->Encoding = "base64"; 

	$mail->Username = $test_gmail_user;
	$mail->Password = $test_gmail_password;      

	$mail->FromName = $sendername;
	$mail->Subject = $subject;
	$mail->Body = $content."\n\n\nFrom: ".$from;
	$mail->AddAddress($test_gmail_user);       

	mysql_query("INSERT INTO mail (subject,email,name,content) VALUES ('$subject','$from','$sendername','$filted_content')");

	if(!$mail->Send()) {
		 echo "Mailer Error: " . $mail->ErrorInfo;
	}
	else {
		 echo "Successful";
	}
?>

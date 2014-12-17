$(document).ready(function() {
	response();
	$(window).resize(function() { response(); });

	function response() {
		var scr_h = $(window).height();
		$('.page').css('height', scr_h + 'px');
		$('.content').each(function() {
			var ph = parseInt($(this).css('height').split('px')[0]);
			ph += parseInt($(this).css('padding-bottom').split('px')[0]); console.log(this);
			console.log(ph);
			var hh = $('.header').css('height').split('px')[0];
			if(ph > scr_h - hh) { $(this).parent().css('overflow-y', 'scroll'); }
			else { $(this).parent().css('overflow-y', 'hidden'); }
		});
	}

	$('#to_login_btn').click(function() {
		response();
		$('#intro').css('left', '-100%');
		$('#login').css('left', '0%');
	});

	$('#login_btn').click(function() {
		var username = $('[name=login_username]').val();
		var password = $('[name=login_password]').val();
		if(username == '' && password == '') {
			$('#login_msg').text('請輸入帳號密碼!');
			$('#login_msg').css('display', 'block');
		}
		else if(username == '' && password != '') {
			$('#login_msg').text('請輸入帳號!');
			$('#login_msg').css('display', 'block');
		}
		else if(username != '' && password == '') {
			$('#login_msg').text('請輸入密碼!');
			$('#login_msg').css('display', 'block');
		}
		else {
			$('#login_msg').text('');
			$('#login_msg').css('display', 'none');
			// Ajax to login
			$.ajax({
				url: 'php/login.php',
				data: {
					username: username,
				password: password
				},
				type: 'POST',
				success: function(res) {
					console.log(res);
					if(parseInt(res) == 0) {
						$('#login_msg').text('帳號或密碼錯誤!');
						$('#login_msg').css('display', 'block');
					}
					else if(parseInt(res) == 1) {
						$('#login_msg').text('');
						$('#login_msg').css('display', 'none');
						response();
						$('#report').css('left', '0%');
						$('#login').css('left', '-100%');
						$('intro').css('display', 'none');
						$('login').css('display', 'none');
						$('signup').css('display', 'none');
						$('register').css('display', 'none');
						$('#menu').css('display', 'block');
					}
					else {
						$('#login_msg').text('BugGG');
						$('#login_msg').css('display', 'block');
					}
				}
			});
		}
	});

	$('#back_home_btn').click(function() {
		response();
		$('#intro').css('left', '0%');
		$('#login').css('left', '100%');
	});

	$('#to_signup_btn').click(function() {
		response();
		$('#login').css('left', '-100%');
		$('#signup').css('left', '0%');
	});

	$('#signup_prev_btn').click(function() {
		response();
		$('#login').css('left', '0%');
		$('#signup').css('left', '100%');
		$('#signup_1_msg').text('');
		$('#signup_1_msg').css('display', 'none');
	});

	$('#signup_next_btn').click(function() {
		var username = $('[name=signup_username]').val();
		var password = $('[name=signup_password]').val();
		if(username == '' && password == '') {
			response();
			$('#signup_1_msg').text('請輸入帳號密碼!');
			$('#signup_1_msg').css('display', 'block');
		}
		else if(username == '' && password != '') {
			response();
			$('#signup_1_msg').text('請輸入帳號!');
			$('#signup_1_msg').css('display', 'block');
		}
		else if(password.length < 6) {
			response();
			$('#signup_1_msg').text('密碼不可小於6碼！');
			$('#signup_1_msg').css('display', 'block');
		}
		
		else if(username != '' && password == '') {
			response();
			$('#signup_1_msg').text('請輸入密碼!');
			$('#signup_1_msg').css('display', 'block');
		}
		else {
			$('#signup_1_msg').text('');
			$('#signup_1_msg').css('display', 'none');
			response();
			$('#signup').css('left', '-100%');
			$('#register').css('left', '0%');
		}
	});

	$('#register_prev_btn').click(function() {
		response();
		$('#signup').css('left', '0%');
		$('#register').css('left', '100%');
	});

	$('#signup_submit_btn').click(function() {
		var username = $('[name=signup_username]').val();
		var password = $('[name=signup_password]').val();
		var name = $('[name=signup_name]').val();
		var gender = $('[name=signup_gender]').val();
		var email = $('[name=signup_email]').val();
		var phone = $('[name=signup_phone]').val();
		var address = $('[name=signup_address]').val();
		var msg = [];
		if(name == '') { msg.push('姓名'); }
		if(gender == '') { msg.push('性別'); }
		if(email == '') { msg.push('電子郵件'); }
		if(phone == '') { msg.push('電話'); }
		if(address == '') { msg.push('地址'); }
		if(msg.length != 0) {
			var out = msg[0]
		for(var i = 1; i < msg.length; i++) {
			out += '、' + msg[i];
		}
	$('#signup_2_msg').text('請輸入 ' + out);
	$('#signup_2_msg').css('display', 'block');
	response();
		}
		else {
			$('#signup_2_msg').text('');
			$('#signup_2_msg').css('display', 'none');
			response();
			// Ajax to sign up
			$.ajax({
				url: 'php/add_user.php',
				type: 'POST',
				data: {
					username: username,
				password: password,
				name: name,
				gender: gender,
				email: email,
				phone: phone,
				address: address
				},
				success: function(res) {
					console.log(res);
					if(parseInt(res) == 0) {;
					}
					else if(parseInt(res) == 1) {
						response();
						$('#report').css('left', '0%');
						$('#login').css('left', '-100%');
						$('intro').css('display', 'none');
						$('login').css('display', 'none');
						$('signup').css('display', 'none');
						$('register').css('display', 'none');
						$('#menu').css('display', 'block');
					}
				}
			});
		}
	});
	//report action
	$('#report_tab').click(function() {
		$('.menu_item_tab').css('left', '0%');
		$('#report').css('left', '0%');
		$('#all').css('left', '100%');
		$('#user').css('left', '100%');
		$('#contact').css('left', '100%');
	});

	$("#report").swipe({
		swipe:function(event, direction, distance, duration, fingerCount, fingerData) {
			if(direction == 'left') {
				$('.menu_item_tab').css('left', '25%');
				$('#report').css('left', '-100%');
				$('#all').css('left', '0%');
				$('#user').css('left', '100%');
				$('#contact').css('left', '100%');
			}
			else if(direction == 'right') {
				// Nothing to do
				;}
		},
		threshold:0
	});

	//all action
	$('#all_tab').click(function() {
		$('.menu_item_tab').css('left', '25%');
		$('#report').css('left', '-100%');
		$('#all').css('left', '0%');
		$('#user').css('left', '100%');
		$('#contact').css('left', '100%');
	});

	$("#all").swipe({
		swipe:function(event, direction, distance, duration, fingerCount, fingerData) {
			if(direction == 'left') {
				$('.menu_item_tab').css('left', '50%');
				$('#report').css('left', '-100%');
				$('#all').css('left', '-100%');
				$('#user').css('left', '0%');
				$('#contact').css('left', '100%');
									}
			else if(direction == 'right') {
				$('.menu_item_tab').css('left', '0%');
				$('#report').css('left', '0%');
				$('#all').css('left', '100%');
				$('#user').css('left', '100%');
				$('#contact').css('left', '100%');
			};
		},
		threshold:0
	});

	//user action
	$('#user_tab').click(function() {
		$('.menu_item_tab').css('left', '50%');
		$('#report').css('left', '-100%');
		$('#all').css('left', '-100%');
		$('#user').css('left', '0%');
		$('#contact').css('left', '100%');
	});

	$("#user").swipe({
		swipe:function(event, direction, distance, duration, fingerCount, fingerData) {
			if(direction == 'left') {
				$('.menu_item_tab').css('left', '75%');
				$('#report').css('left', '-100%');
				$('#all').css('left', '-100%');
				$('#user').css('left', '-100%');
				$('#contact').css('left', '0%');
												}
			else if(direction == 'right') {
				$('.menu_item_tab').css('left', '25%');
				$('#report').css('left', '-100%');
				$('#all').css('left', '0%');
				$('#user').css('left', '100%');
				$('#contact').css('left', '100%');
					};
		},
		threshold:0
	});


	//contact action
	$('#contact_tab').click(function() {
		$('.menu_item_tab').css('left', '75%');
		$('#report').css('left', '-100%');
		$('#all').css('left', '-100%');
		$('#user').css('left', '-100%');
		$('#contact').css('left', '0%');
	});
	$("#contact").swipe({
		swipe:function(event, direction, distance, duration, fingerCount, fingerData) {
			if(direction == 'left') {
				$('.menu_item_tab').css('left', '0%');
				$('#report').css('left', '0%');
				$('#all').css('left', '100%');
				$('#user').css('left', '100%');
				$('#contact').css('left', '100%');
				;}
			else if(direction == 'right') {
				$('.menu_item_tab').css('left', '50%');
				$('#report').css('left', '-100%');
				$('#all').css('left', '-100%');
				$('#user').css('left', '0%');
				$('#contact').css('left', '100%');
						};
		},
		threshold:0
	});

});

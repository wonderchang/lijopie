$ document .ready ->
	$ '.positive' .click ->
		data = do
			subject:  $ '.mail .subject input' .val!
			content:  $ '.mail .content textarea' .val!
			name:     $ '.mail .name input' .val!
			from:    	$ '.mail .from input' .val!

		$ '.msgbox' .append "<div class='ui active loader large'></div>"

		$.ajax do
			url: \php/mail.php, type: \POST, data: data
			success: (result) ->
				console.log result
				$ '.msgbox' .children!.fade-out 350, ->
					if result .index-of \Successful isnt -1
						$ '.msgbox' .add-class "vh5"
												.text "寄件成功!我們將盡快為您服務!"
												.append "<a href='index.html'>返回首頁</a>"
					else if result .index-of \Error isnt -1
						$ '.msgbox' .add-class \vh5 .text \寄件失敗!我們將盡快修復!


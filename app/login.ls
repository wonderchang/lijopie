if 1 is cookie.check! then location.href = "#{path.dirname!}report.html"

$ document .ready ->

  $ \button .click ->
    data = do
      username: $ '.username input' .val!
      password: $ '.password input' .val!

    if data.username is '' or data.password is ''
      $ '.form .message .header' .text \請輸入帳號與密碼
      $ \.form .add-class \error
      return
    else
      $ \.form .remove-class \error
      $ '.form .message .header' .text ''

    $.ajax do
      url: \php/login.php, type: \POST, data: data
      before-send: ->
        $ \.form .remove-class \error
        $ '.form .message .header' .text ''
        $ '.form' .add-class \loading
      success: ->
        if 32 is it.length
          cookie.set it
          location.href = path.dirname!+\report.html?0
        else if 0 is parseInt it
          $ '.form' .remove-class \loading
          $ '.form .message .header' .text \帳號或密碼錯誤
          $ \.form .add-class \error
        else
          location.href = path.dirname!


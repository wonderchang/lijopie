if 1 is cookie.check! then location.href = "#{path.dirname!}report.html"

$ document .ready ->

  $ \.dropdown .dropdown!

  $ \button .click ->
    data = do
      name:     $ '.form .name input'     .val!
      gender:   $ '.form .gender input'   .val!
      email:    $ '.form .email input'    .val!
      username: $ '.form .username input' .val!
      password: $ '.form .password input' .val!
      verify:   $ '.form .verify input'   .val!

    check-null = true
    if data.name     is '' then $ '.form .name'     .add-class \error; check-null = false else $ '.form .name'     .remove-class \error
    if data.gender   is '' then $ '.form .gender'   .add-class \error; check-null = false else $ '.form .gender'   .remove-class \error
    if data.email    is '' then $ '.form .email'    .add-class \error; check-null = false else $ '.form .email'    .remove-class \error
    if data.username is '' then $ '.form .username' .add-class \error; check-null = false else $ '.form .username' .remove-class \error
    if data.password is '' then $ '.form .password' .add-class \error; check-null = false else $ '.form .password' .remove-class \error
    if data.verify   is '' then $ '.form .verify'   .add-class \error; check-null = false else $ '.form .verify'   .remove-class \error
    if !check-null
      $ '.form .message .header' .text \以上欄位皆務必填寫
      $ \.form .add-class \error
      return
    else
      $ \.form .remove-class \error
      $ '.form .message .header' .text ''

    if data.password isnt data.verify
      $ '.form .message .header' .text \密碼確認錯誤
      $ \.form .add-class \error
      $ '.form .verify' .add-class \error
      return
    else
      $ \.form .remove-class \error
      $ '.form .message .header' .text ''
      $ '.form .verify' .remove-class \error

    $.ajax do
      url: \php/add-user.php, type: \POST, data: data
      before-send: ->
        $ \.form .remove-class \error
        $ '.form .message .header' .text ''
        $ '.form' .add-class \loading
      success: ->
        switch parseInt it
        | 1 => # signup successfully
          $ '.form .email' .remove-class \error
          $ '.form .username' .remove-class \error
          $ \.dimmer .dimmer \show
            .dimmer on-hide: ->
              location.href = path.dirname!+\login.html
        | 2 => # repeat email
          $ '.form' .remove-class \loading
          $ '.form .message .header' .text \此信箱已註冊過
          $ \.form .add-class \error
          $ '.form .email' .add-class \error
        | 3 => # repeat username
          $ '.form' .remove-class \loading
          $ '.form .message .header' .text \此帳號已註冊過
          $ \.form .add-class \error
          $ '.form .username' .add-class \error
        | 4 => # repeat email & username
          $ '.form' .remove-class \loading
          $ '.form .message .header' .text \此信箱與帳號皆已註冊過
          $ \.form .add-class \error
          $ '.form .email' .add-class \error
          $ '.form .username' .add-class \error
        | otherwise =>
          location.href = path.dirname!


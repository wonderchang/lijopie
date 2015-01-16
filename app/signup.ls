$ document .ready ->

  check = cookie.check!
  if check is 1 then location.href = "#{path.dirname!}report.html"
  else if check is 2 then location.href = "#{path.dirname!}error.html"
  resize.cover!

  $ \#signup-btn .click ->
    data = do
      name: $ '.form .name input' .val!
      gender: $ '.form .gender input' .val!
      email: $ '.form .email input' .val!
      username: $ '.form .username input' .val!
      password: $ '.form .password input' .val!
      verify: $ '.form .verify input' .val!

    # 1. not null
    error-count = 0
    for key in Object.keys data
      if data[key] is '' then error-count++
    if error-count is 0 then error ''
    else error \請確認以下資料皆不為空值; return

    # 2. password = verify
    if data.password isnt data.verify
      error \重新輸入密碼錯誤; return
    else error ''

    # Ajax
    $.ajax do
      url: \php/add-user.php
      type: \POST
      data: data
      before-send: ->
        error ''; $ '.form' .add-class \loading
      success: ->
        it = parseInt it
        if it is 1
          $ \.dimmer .dimmer \show
            .dimmer on-hide: ->
              location.href = path.dirname!+\login.html
        else if it is 2 # repeat email
          $ '.form' .remove-class \loading
          error \此信箱已註冊過
        else if it is 3 # repeat username
          $ '.form' .remove-class \loading
          error \此帳號已註冊過
        else if it is 4 # repeat email & username
          $ '.form' .remove-class \loading
          error \此信箱與帳號皆已註冊過
        else
          location.href = path.dirname!+\error.html

function error header
  if header isnt ''
    $ '.form .message .header' .text header
    $ \.form .add-class \error
  else
    $ '.form .message .header' .text header
    $ \.form .remove-class \error

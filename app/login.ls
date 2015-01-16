$ document .ready ->

  check = cookie.check!
  if check is 1 then location.href = "#{path.dirname!}report.html"
  else if check is 2 then location.href = "#{path.dirname!}error.html"
  resize.cover!

  $ \#login-btn .click ->
    data = do
      username: $ '.form .username input' .val!
      password: $ '.form .password input' .val!

    # 1. not null
    error-count = 0
    for key in Object.keys data
      if data[key] is '' then error-count++
    if error-count is 0 then error ''
    else error \請確認以下資料皆不為空值; return

    $.ajax do
      url: \php/login.php
      type: \POST
      data: data
      before-send: ->
        error ''; $ '.form' .add-class \loading
      success: ->
        if it.length == 32
          cookie.set it
          location.href = path.dirname!+\report.html
        else if parseInt(it) is 0
          $ '.form' .remove-class \loading
          error \帳號密碼錯誤
        else
          location.href = path.dirname!+\error.html

function error header
  if header isnt ''
    $ '.form .message .header' .text header
    $ \.form .add-class \error
  else
    $ '.form .message .header' .text header
    $ \.form .remove-class \error

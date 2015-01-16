$ document .ready ->

  # resize
  resize.cover!

  # Login and signup

!function show-login
  if it isnt undefined
    $ '#login .message .header' .text it.header
    $ '#login .message .content' .text it.content
    $ '#login .form' .add-class \error
  else
    $ '#login .message .header' .text ''
    $ '#login .message .content' .text ''
    $ '#login .form' .remove-class \error

!function logining
  console.log \wefwef
  data = do
    username: $ '#login .username input' .val!
    password: $ '#login .password input' .val!
  if data.username is '' or data.password is ''
    console.log \wfe
    show-login header: '錯誤', content: '請輸入帳號密碼'


if 1 isnt cookie.check! then location.href = path.dirname!+\login.html

$ document .ready ->
  $ \.dropdown .dropdown!
  $ \.checkbox .checkbox!

$ '.column .button' .click !->

  id = this.id.7; upload-id = "file-to-upload-#id"
  document.get-element-by-id upload-id .click!

  $ '#'+upload-id .change !->
    fd = new Form-data!
    file = document.get-element-by-id upload-id .files.0
    fd.append \photo, file

    if !file then return
    if file.type isnt /image\/(jpeg|jpg|png|bmp|gif)/
      return show-msg-modal '照片格式須為 .png, .jpg, jpeg, bmp'
    if 5000000 < file.size
      return show-msg-modal '照片大小須小於 5 MB'

    block = "\#picture-#id .progress-block"
    img   = "\#picture-#id img"
    $ block .remove-class \none .add-class \block

    xhr = new XML-http-request!

    xhr.upload.add-event-listener \progress, !->
      percent = Math.round it.loaded * 100 / it.total
      $ block+' .progress .label' .text percent+" %"
      $ block+' .progress' .progress percent: percent
    , false

    xhr.add-event-listener \load, !->
      console.log it.current-target.response
      $ block .remove-class \block .add-class \none
      $ img   .remove-class \none  .add-class \block
        .attr \src, 'uploads/'+it.current-target.response

    xhr.add-event-listener \error, !->
      console.log it
    , false

    xhr.add-event-listener \abort, !->
      console.log it
    , false

    xhr.open \POST, \php/upload.php
    xhr.send fd

$ \#submit .click !->
  data = do
    region:    $ '[name=region]'     .val!
    subject:   $ '[name=subject]'    .val!
    content:   $ '#content textarea' .val!
    anonymous: $ '[name=anonymous]'  .prop \checked
    cookie:    cookie.get!
  pic =
    * $ '#picture-1 img' .attr \src
    * $ '#picture-2 img' .attr \src
    * $ '#picture-3 img' .attr \src
  check-null = true; pic-num = 0; err-msg = ''
  for i til pic.length then if pic[i] isnt undefined then ++pic-num; data["picture#pic-num"] = pic[i]
  if pic-num < 2 then err-msg += \至少上傳兩張照片，一張車頭、一張車尾。
  else if pic-num is 2 then data.picture3 = ''
  if data.region   is '' then check-null = false
  if data.subject  is '' then check-null = false
  if data.content  is '' then check-null = false
  if !check-null then err-msg += \地區、違規事項及內容說明請務必填寫。
  if err-msg isnt ''
    $ '.form .message .header' .html err-msg
    $ \.form .add-class \error
    return
  else $ \.form .remove-class \error
  if data.anonymous then data.anonymous = 1 else data.anonymous = 0
  $.ajax do
    url: \php/add-report.php
    type: \POST
    data: data
    before-send: !->
      $ \#react .modal closable: false .modal \show
    success: !->
      $ '#react .ui.text.loader' .remove!
      switch parseInt it
      | 0 =>
        $ '#react i' .add-class 'question yellow'
        $ '#react .header' .add-class 'yellow' .text \檢舉系統送件有問題，已儲存您的檢舉資料，稍後將會送出
      | 1 =>
        $ '#react i' .add-class 'checkmark green'
        $ '#react .header' .add-class 'green' .text \檢舉已送件至警察局，感謝您的檢舉
      | 2 =>
        $ '#react i' .add-class 'close red'
        $ '#react .header' .add-class 'red' .text \檢舉失敗
      $ '#react .content' .add-class \block
      set-timeout (!-> location.href = path.dirname!+\record.html), 3000


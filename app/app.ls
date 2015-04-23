cookie = do
  cn: \lijopie

  get: !->
    name = this.cn + '='
    for ca in (document.cookie / ';')
      ca = ca.trim!
      if (ca.index-of name) is 0
        return ca.substring name.length, ca.lengthA
    return ''

  set: ->
    d = new Date!
    d.set-time d.get-time!+24*60*60*1000
    expires = 'expires='+d.to-GMT-string!
    document.cookie = this.cn+'='+it+';'+expires

  check: ->
    flag = false
    $.ajax do
      url: \php/check-cookie.php
      type: \POST
      data: cookie: this.get!
      async: false
      success: -> flag := parseInt it
    flag

path = do
  dirname: ->
    arr = location.href.split '/'
    if arr[arr.length - 1] isnt ''
      (location.href.split arr[arr.length - 1]).0
    else location.href

$ '#menu-btn' .click !->
  $ \#menu-list
    .sidebar \setting, \transition, \push
    .sidebar \toggle, duration: 200

if cookie.check! then state = \after else state = \before
$ '#setting-btn' .click !->
  $ '#'+state+'-login-setting-list'
    .sidebar \setting, \transition, \push
    .sidebar \toggle, duration: 200

$ '#sign-out-btn' .click !->
  cookie.set ''
  location.href = path.dirname!

$ \.start-report .click !->
  document.get-element-by-id \file-to-upload .click!

$ \#file-to-upload .change !->

  $ \#progress-modal .modal \show .modal closable: false

  fd = new Form-data!; photo = ''; wait = 800
  file = document.get-element-by-id(\file-to-upload).files.0
  fd.append \photo, file

  if file.type isnt /image\/(jpeg|jpg|png|bmp|gif)/
    return show-msg-modal '照片格式須為 .png, .jpg, jpeg, bmp'
  if 5000000 < file.size
    return show-msg-modal '照片大小須小於 5 MB'

  xhr = new XML-http-request!

  xhr.upload.add-event-listener \progress, !->
    percent = Math.round it.loaded * 100 / it.total
    $ '.progress .label' .text percent+" %"
    $ \.progress .progress percent: percent
  , false

  xhr.add-event-listener \load, !->
    photo := it.current-target.response
    $ \#progress-modal .modal \hide
    $ '#verify-modal .header' .html \照片檢視
    $ '#verify-modal .content' .html "<img src='uploads/#photo' style='width: 100%'>"
    set-timeout !->
      $ \#verify-modal .modal do
        closable: false
        on-approve: show-report-modal
      .modal \show
      $ \#progress .progress percent: 0
      $ '#progress .label' .text "0 %"
    , wait
  , false

  xhr.add-event-listener \error, !->
    console.log it
  , false

  xhr.add-event-listener \abort, !->
    console.log it
  , false

  xhr.open \POST, \php/upload.php
  xhr.send fd

  !function show-msg-modal
    $ '#msg-modal .content' .html it
    $ '#msg-modal' .modal \show

  !function show-report-modal
    $ \#verify-modal .modal \hide
    set-timeout !->
      $ \#report-modal .modal do
        closable: false
        on-approve: send-report
      .modal \show
      $ \.dropdown .dropdown!
      $ \.checkbox .checkbox!
    , wait

  !function send-report
    data = do
      region:    $ '[name=region]'     .val!
      subject:   $ '[name=subject]'    .val!
      content:   $ '#content textarea' .val!
      anonymous: $ '[name=anonymous]'  .prop \checked
      cookie:    cookie.get!
      photo:     photo
    check-null = true
    if data.region  is '' then check-null = false
    if data.subject is '' then check-null = false
    if data.content is '' then check-null = false
    if !check-null
      $ '.form .message .header' .text \以上資料皆務必填寫
      $ \.form .add-class \error
      show-report-modal!
      return
    $ \.form .remove-class \error
    $ '.form .message .header' .text ''
    if data.anonymous then data.anonymous = 1 else data.anonymous = 0
    $.ajax do
      url: \php/add-report.php
      type: \POST
      data: data
      before-send: !->
        $ \#report-modal .modal \hide
      success: !->
        switch parseInt it
        | 0 => set-timeout (!-> show-msg-modal "<h1 class='ui header red  '><i class='icon close    '></i>檢舉失敗</h1>"), wait
        | 1 => set-timeout (!-> show-msg-modal "<h1 class='ui header green'><i class='icon checkmark'></i>檢舉成功</h1>"), wait
        $ \textarea .val ''

!function append-report
  src = it
  img = $ "<div>" .add-class \report-img
    .css \overflow, \hidden
    .css \width, \100%
    .css \height, \240px
    .css \cursor, \pointer
    .append (
      $ "<img>" .attr \src, src.img
        .css \width, \100%
    )
    .on \click, !->
      content = "<img src='#{src.img}' style='width: 100%'>"
      content += "<br><label>時間：#{src.time}</label>"
      content += "<br><label>區域：#{src.region}</label>"
      content += "<br><label>事項：#{src.subject}</label>"
      content += "<br><label>內容：#{src.content}</label>"
      $ '#detail .content' .html content
      $ \#detail .modal \show
  time = $ "<div>" .add-class \ui
    .add-class \header
    .add-class \our-centered
    .add-class \tiny
    .text it.time
  region = $ "<div>" .add-class \ui
    .add-class \gray
    .add-class \label
    .text it.region
  subject = $ "<div>" .add-class \ui
    .add-class \red
    .add-class \label
    .text it.subject
  column = $ "<div>"
    .add-class \column
    .append-to '#report .grid'
  $ "<div>" .add-class \ui
    .add-class \segment
    .append img
    .append time
    .append region
    .append subject
    .append-to column

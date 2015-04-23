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

photo = ''
$ \.start-report .click ->
  document.get-element-by-id \file-to-upload .click!

$ \#file-to-upload .change ->
  $ \#modal-progress .modal \show .modal closable: false
  fd = new Form-data!
  fd.append \photo, document.get-element-by-id(\file-to-upload).files.0
  xhr = new XML-http-request!
  xhr.upload.add-event-listener \progress, upload-progress, false
  xhr.add-event-listener \load, upload-complete, false
  xhr.add-event-listener \error, upload-failed, false
  xhr.add-event-listener \abort, upload-canceled, false
  xhr.open \POST, \php/upload.php
  xhr.send fd

!function upload-progress
  percent = Math.round it.loaded * 100 / it.total
  $ '#progress .label' .text percent+" %"
  $ \#progress .progress percent: percent

!function upload-complete
  console.log photo := it.current-target.response
  set-timeout !->
    modal-photo photo
    $ \#progress .progress percent: 0
    $ '#progress .label' .text "0 %"
  , 1000

!function upload-failed
  console.log it

!function upload-canceled
  console.log it

!function modal-photo
  $ \#modal-progress
    .modal \hide
  $ '#upload-photo'
    .attr \src, "uploads/#{it}"
    .css \width, \100% #(window.inner-height*0.6)+'px'
  $ \#modal-photo
    .modal do
      closable: false
      on-approve: modal-form
      on-deny: cancel-all-form
    .modal \show

!function modal-form
  $ \#modal-photo
    .modal \hide
  $ \#modal-form
    .modal do
      closable: false
      on-approve: modal-form-send
      on-deny: cancel-all-form
    .modal \show
  $ \.dropdown .dropdown!
  $ \.checkbox .checkbox!

!function modal-form-send
  region = parseInt($ '[name=region]' .val!)
  theme = parseInt($ '[name=theme]' .val!)
  content = $ '#content textarea' .val!
  anonymous = $ '[name=anonymous]' .prop \checked
  /*
  if region is '' then set-timeout modal-form, 10
  else if theme is '' then set-timeout modal-form, 10
  else if content is '' then set-timeout modal-form, 10
  else
  */
  if anonymous then anonymous = 1 else anonymous = 0
  data = do
    region: region
    theme: theme
    content: content
    anonymous: anonymous
    cookie: cookie.get!
    photo: photo
  $.ajax do
    url: \php/add-report.php
    type: \POST
    data: data
    success: modal-submit

!function modal-submit
  $ \#modal-submit
    .modal do
      closable: false
      on-approve: ->
        location.href = path.dirname!+\report.html
    .modal \show

!function cancel-all-form
  location.href = path.dirname!

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
      content += "<br><label>類型：#{src.type}</label>"
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
  type = $ "<div>" .add-class \ui
    .add-class \red
    .add-class \label
    .text it.type
  column = $ "<div>"
    .add-class \column
    .append-to '#report .grid'
  $ "<div>" .add-class \ui
    .add-class \segment
    .append img
    .append time
    .append region
    .append type
    .append-to column

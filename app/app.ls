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

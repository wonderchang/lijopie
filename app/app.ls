$ \.dropdown .dropdown!
$ \.checkbox .checkbox!

resize = do
  cover: !->
    h = window.innerHeight+5
    w = window.innerWidth
    cover-h = this.height '.cover .column'
    cover-mv = this.v-margin '.cover .column'
    header-h = this.height \#header
    padding-shift = (h - cover-h - cover-mv) / 2
    $ '.cover .column' .css \padding-top, padding-shift+\px
    $ '.cover .column' .css \padding-bottom, padding-shift+\px
  height: -> parseInt (($ it .css \height) / 'px').0
  v-padding: ->
    top = parseInt (($ it .css \padding-top) / 'px').0
    bot = parseInt (($ it .css \padding-bottom) / 'px').0
    top+bot
  v-margin: ->
    top = parseInt (($ it .css \margin-top) / 'px').0
    bot = parseInt (($ it .css \margin-bottom) / 'px').0
    top+bot


cookie = do
  cn: \triplebaby

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
    (location.href.split arr[arr.length - 1]).0


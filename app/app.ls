$ \.dropdown .dropdown!

resize = do
  cover: !->
    h = window.innerHeight
    w = window.innerWidth
    cover-h = (($ '.cover .column' .css \height) / 'px').0
    header-h = (($ \#header .css \height) / 'px').0
    cover-pt = (($ '.cover .column' .css \padding-top) / 'px').0
    cover-pb = (($ '.cover .column' .css \padding-bottom) / 'px').0
    cover-mt = (($ '.cover .column' .css \margin-top) / 'px').0
    cover-mb = (($ '.cover .column' .css \margin-bottom) / 'px').0
    padding-shift = (h - cover-h - cover-mt - cover-mb) / 2
    $ '.cover .column' .css \padding-top, padding-shift+\px
    $ '.cover .column' .css \padding-bottom, padding-shift+\px

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

path = do
  dirname: ->
    arr = location.href.split '/'
    (location.href.split arr[arr.length - 1]).0


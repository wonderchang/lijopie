host = "http://merry.ee.ncku.edu.tw/~wonder/triplebaby"

cookie = {
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

}

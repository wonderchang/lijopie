require! <[phantom fs]>

url = "http://www.tnpd.gov.tw/chinese/home.jsp?serno=201012130069&mserno=201012130066&menudata=TncgbMenu&contlink=ap/mail1.jsp&level2=Y"
user-agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36"

phantom.create (ph) ->
  ph.create-page (page) ->
    page.set \setting, user-agent: user-agent
    page.open url, ->
      page.get-cookies ->
        output = name: it.0.name, value: it.0.value
        page.get-content ->
          it = it / '\n'
          if it.873 is /.*<b>(\d+)<\/b>.*/ then output.verify = that.1
          console.log output

if 1 isnt cookie.check! then location.href = path.dirname!+\login.html

region-list = <[
  東區   北區   南區   中西區 安南區
  安平區 七股區 下營區 仁德區 佳里區
  六甲區 北門區 南化區 善化區 大內區
  學甲區 安定區 官田區 將軍區 山上區
  左鎮區 後壁區 新化區 新市區 新營區
  東山區 柳營區 楠西區 歸仁區 永康區
  玉井區 白河區 西港區 關廟區 鹽水區
  麻豆區 龍崎區
  ]>

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
    subject:   $ '[name=subject]'    .val!
    address:   $ '[name=address]'    .val!
    region:    $ '[name=region]'     .val!
    content:   $ '#content textarea' .val!
    anonymous: $ '[name=anonymous]'  .prop \checked
    cookie:    cookie.get!
  if marker isnt '' then data.marker = marker.position.to-string! else data.marker = ''
  if gps isnt '' then data.gps = '('+gps.coords.latitude+', '+gps.coords.longitude+')' else data.gps = ''
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
  if data.address  is '' then check-null = false
  if !check-null then err-msg += \地址、地區、違規事項及內容說明請務必填寫。
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
      return console.log it
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

$ \#no-people .click !->
  content = $ '#content textarea' .val!
  if content isnt '' then content += ', '
  if content isnt /.*車內無人.*/ then $ '#content textarea' .val content+'車內無人'

address = ''; region = ''; marker = ''; map = null; gps = ''
$ \#open-map .click !->
  $ '.main' .css \left, \-100%
  $ '#header' .css \left, \-100%
  $ '.right-page' .css \left, \0% .css \display, \block
  $ '#map-submit' .css \display, \block
  if map is null then load-map!

  $ \#map-submit .click !->
    $ this .css \display, \none
    $ '.right-page' .css \left, \100% .css \display, \none
    $ '.main' .css \left, \0%
    $ '#header' .css \left, \0%
    $ '[name=address]' .val address
    region-id = 1+region-list.index-of region
    $ '#region .dropdown' .dropdown 'set selected', region-id
      .dropdown 'set value', region-id

!function load-map
  # Init layout
  script = document.create-element \script
  script.src = 'https://maps.googleapis.com/maps/api/js?libraries=places&sensor=true&callback=initMap&v=3.exp&language=zh-TW'
  document.body.append-child script

!function init-map
  map := new google.maps.Map (document.get-element-by-id \map), do
    center: new google.maps.Lat-lng 23.1506238, 120.3458693
    map-type-id: google.maps.Map-type-id.ROADMAP
    zoom: 11
  geocoder  = new google.maps.Geocoder!
  if navigator.geolocation then navigator.geolocation.get-current-position !->
    gps := it
    map.pan-to new google.maps.Lat-lng it.coords.latitude, it.coords.longitude
    map.set-zoom 17

  google.maps.event.add-listener map, \click, ->
    if marker then marker.set-map null
    marker := new google.maps.Marker position: it.lat-lng
    marker.set-map map
    get-place-address it.lat-lng

  !function get-place-address place
    geocoder.geocode lat-lng: place, (r, s) !->
      if s isnt \OK then return get-place-address place
      c = r.0.address_components
      address := r.0.formatted_address
      region  := c[c.length - 4].long_name
      info-window = new google.maps.Info-window content: address
      info-window.open map, marker


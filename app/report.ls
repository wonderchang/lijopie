if 1 isnt cookie.check! then location.href = "#{path.dirname!}login.html"

if 840 < window.inner-width
  $ '#report .grid' .add-class \four .add-class \column
else if 480 <= window.inner-width <= 840
  $ '#report .grid' .add-class \two .add-class \column
else if window.inner-width < 480
  $ '#report .grid' .add-class \one  .add-class \column

$ window .resize ->
  $ '.grid' .remove-class \column
    .remove-class \one
    .remove-class \two
    .remove-class \four
  if 840 < window.inner-width
    $ '#report .grid' .add-class \four .add-class \column
  else if 480 <= window.inner-width <= 840
    $ '#report .grid' .add-class \two .add-class \column
  else if window.inner-width < 480
    $ '#report .grid' .add-class \one  .add-class \column

$ document .ready ->

  if 0 is parseInt location.search.1
    $ '#after-login-setting-list'
      .sidebar \setting, \transition, \push
      .sidebar \toggle, duration: 200

  $.ajax do
    url: \php/get-self-report.php
    type: \POST
    data: cookie: cookie.get!
    success: ->
      for i in JSON.parse it
        append-report do
          img: i.picture
          time: i.reporttime
          region: i.region_name
          type: i.theme_name
          content: i.content

# vi:ei:ft=ls:nowrap:sw=2:ts=2

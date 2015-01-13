$ document .ready ->

  # Response the cover section
  h = window.innerHeight
  w = window.innerWidth
  cover-h = (($ \#cover-section .css \height) / 'px').0
  header-h = (($ \#header .css \height) / 'px').0
  cover-pt = (($ \#cover-section .css \padding-top) / 'px').0
  cover-pb = (($ \#cover-section .css \padding-bottom) / 'px').0
  cover-mt = (($ \#cover-section .css \margin-top) / 'px').0
  cover-mb = (($ \#cover-section .css \margin-bottom) / 'px').0
  padding-shift = (h - cover-h - cover-mt - cover-mb) / 2
  $ \#cover-section .css \padding-top, padding-shift+\px
  $ \#cover-section .css \padding-bottom, padding-shift+\px

  # Login and signup
  $ \#report-btn .click !-> show-login!

  /*
  $.ajax do
    url: \php/check-cookie.php
    type: \POST
    data: cookie: cookie.get!
    success: ->
      if it is 0
        $ \#login .modal \show
      else if it is 1
        location.href = "#host/report.html"
  */


  !function show-login
    $ \#signup
      .modal \hide
    $ \#login
      .modal do
        on-approve: !-> console.log \logining
        on-deny: !-> show-signup!
      .modal \show

  !function show-signup
    $ \#login
      .modal \hide
    $ \#signup
      .modal do
        on-approve: !-> console.log \signuping
        on-deny: !-> show-login!
      .modal \show



  /*
  for i to 7
    append-latest-report {
      img: \res/demo1.jpg
      time: "2015/01/01 12:00:00"
      region: \東區
      type: \紅線違規停車
    }
  */

  function append-latest-report
    img = $ "<div>" .add-class \report-img
      .append ($ "<img>" .attr \src, it.img)
    time = $ "<div>" .add-class \ui
      .add-class \header
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
      .append-to \#latest-report-content
    $ "<div>" .add-class \ui
      .add-class \segment
      .append img
      .append time
      .append region
      .append type
      .append-to column
    

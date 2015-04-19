$ document .ready ->

  # resize
  resize.cover!

  # Login and signup
  $ \#report-btn .click ->
    switch cookie.check!
    | 0         => location.href = "#{location.href}login.html"
    | 1         => location.href = "#{location.href}report.html"
    | otherwise => location.href = "#{location.href}error.html"

  $.ajax do
    url: \php/get-anonymous.php
    success: ->
      it = JSON.parse it
      for i in it
        append-latest-report do
          img: i.picture
          time: i.reporttime
          region: i.region_name
          type: i.theme_name
          content: i.content

function append-latest-report
  console.log src = it
  img = $ "<div>" .add-class \report-img
    .css \overflow, \hidden
    .css \width, \100%
    .css \height, \130px
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

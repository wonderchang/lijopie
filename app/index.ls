if 1 is cookie.check!
  $ '#cover a' .add-class \start-report .click !->
    document.get-element-by-id \file-to-upload .click!
else
  $ '#cover a' .attr \href, \login.html

if window.inner-width > 480
  $ '#hints    .grid' .add-class \two   .add-class \column
  $ '#features .grid' .add-class \three .add-class \column
else
  $ '#hints    .grid' .add-class \one .add-class \column
  $ '#features .grid' .add-class \one .add-class \column
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
    .remove-class \three
    .remove-class \four
  if window.inner-width > 480
    $ '#hints    .grid' .add-class \two   .add-class \column
    $ '#features .grid' .add-class \three .add-class \column
  else
    $ '#hints    .grid' .add-class \one .add-class \column
    $ '#features .grid' .add-class \one .add-class \column
  if 840 < window.inner-width
    $ '#report .grid' .add-class \four .add-class \column
  else if 480 <= window.inner-width <= 840
    $ '#report .grid' .add-class \two .add-class \column
  else if window.inner-width < 480
    $ '#report .grid' .add-class \one  .add-class \column

$.ajax do
  url: \php/get-anonymous.php
  success: ->
    for i in JSON.parse it
      append-report do
        img: i.picture
        time: i.reporttime
        region: i.region_name
        type: i.theme_name
        content: i.content

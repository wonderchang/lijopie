photo = ''
$ document .ready ->

  check = cookie.check!
  if check is 0 then location.href = "#{path.dirname!}login.html"
  else if check is 2 then location.href = "#{path.dirname!}error.html"

  $ \#logout .click ->
    cookie.set ''
    location.href = path.dirname!

  $ \#start-report .click ->
    document.get-element-by-id \file-to-upload .click!

  $ \#file-to-upload .change ->
    $ \#modal-progress .modal \show .modal closable: false
    fd = new Form-data!
    fd.append \photo, document.get-element-by-id(\file-to-upload).files.0
    xhr = new XML-http-request!
    xhr.upload.add-event-listener \progress, upload-progress, false
    xhr.add-event-listener \load, upload-complete, false
    xhr.add-event-listener \error, upload-failed, false
    xhr.add-event-listener \abort, upload-canceled, false
    xhr.open \POST, \php/upload.php
    xhr.send fd

!function upload-progress
  percent = Math.round it.loaded * 100 / it.total
  $ '#progress .label' .text percent+" %"
  $ \#progress .progress percent: percent

!function upload-complete
  photo := it.current-target.response
  set-timeout !->
    modal-photo photo
    $ \#progress .progress percent: 0
    $ '#progress .label' .text "0 %"
  , 1000

!function upload-failed
  console.log it

!function upload-canceled
  console.log it

!function modal-photo
  $ \#modal-progress
    .modal \hide
  $ '#upload-photo'
    .attr \src, "uploads/#{it}"
    .css \height, (window.inner-height*0.6)+'px'
  $ \#modal-photo
    .modal do
      closable: false
      on-approve: modal-form
      on-deny: cancel-all-form
    .modal \show

!function modal-form
  $ \#modal-photo
    .modal \hide
  $ \#modal-form
    .modal do
      closable: false
      on-approve: modal-form-send
      on-deny: cancel-all-form
    .modal \show

!function modal-form-send
  region = parseInt($ '[name=region]' .val!)
  theme = parseInt($ '[name=theme]' .val!)
  content = $ '#content textarea' .val!
  anonymous = $ '[name=anonymous]' .prop \checked
  /*
  if region is '' then set-timeout modal-form, 10
  else if theme is '' then set-timeout modal-form, 10
  else if content is '' then set-timeout modal-form, 10
  else
  */
  if anonymous then anonymous = 1 else anonymous = 0
  data = do
    region: region
    theme: theme
    content: content
    anonymous: anonymous
    cookie: cookie.get!
    photo: photo
  $.ajax do
    url: \php/add-report.php
    type: \POST
    data: data
    success: modal-submit

!function modal-submit
  $ \#modal-submit
    .modal do
      closable: false
      on-approve: ->
        location.href = path.dirname!+\record.html
    .modal \show

!function cancel-all-form
  location.href = path.dirname!

# vi:ei:ft=ls:nowrap:sw=2:ts=2

$ \#start-report .click ->
  document.get-element-by-id \file-to-upload .click!

$ \#file-to-upload .change ->
  $ \#modal-progress .modal \show
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
  img = it.current-target.response
  set-timeout !->
    modal-photo img
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
      on-approve: modal-form
      on-deny: cancel-all-form
    .modal \show

!function modal-form
  $ \#modal-photo
    .modal \hide
  $ \#modal-form
    .modal do
      on-approve: modal-verify
      on-deny: cancel-all-form
    .modal \show

!function modal-verify
  $ \#modal-form
    .modal \hide
  $ \#modal-verify
    .modal do
      on-approve: modal-submit
      on-deny: cancel-all-form
    .modal \show

!function modal-submit
  $ \#modal-verify
    .modal \hide
  $ \#modal-submit
    .modal do
      on-approve: cancel-all-form
    .modal \show

!function cancel-all-form
  console.log \wefe

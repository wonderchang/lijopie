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
  image = it.current-target.response
  set-timeout !->
    $ \#modal-progress .modal \hide
    $ \#modal-verify
      .modal do
        on-approve: !->
          $ \#modal-verify .modal \hide
          $ \#modal-form
            .modal do
              on-approve: !->
                $ \#modal-form .modal \hide
                $ \#modal-ready .modal \show
            .modal \show
      .modal \show
    $ '#upload-photo'
      .attr \src, "uploads/#image"
      .css \height, (window.inner-height*0.6)+'px'
    set-timeout !->
      $ \#progress .progress percent: 0
      $ '#progress .label' .text "0 %"
    , 1000
  , 1000

!function upload-failed
  console.log it

!function upload-canceled
  console.log it



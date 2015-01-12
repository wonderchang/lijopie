$ \#start-report .click ->
  console.log \startreport
  document.get-element-by-id \file-to-upload .click!

$ \#file-to-upload .change ->
  fd = new Form-data!
  fd.append \photo, document.get-element-by-id(\file-to-upload).files.0
  xhr = new XML-http-request!
  xhr.upload.add-event-listener \progress, upload-progress, false
  xhr.add-event-listener \load, upload-complete, false
  xhr.add-event-listener \error, upload-failed, false
  xhr.add-event-listener \abort, upload-canceled, false
  xhr.open \POST, \php/upload.php
  xhr.send fd

function upload-progress
  console.log it

function upload-complete
  console.log it

function upload-failed
  console.log it

function upload-canceled
  console.log it


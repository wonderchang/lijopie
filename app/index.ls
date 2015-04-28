$ window .resize ->
  $ '.grid' .remove-class 'column one three four'
  if window.inner-width > 480
    $ '#hints    .grid' .add-class 'three column'
    $ '#features .grid' .add-class 'three column'
  else
    $ '#hints    .grid' .add-class 'one column'
    $ '#features .grid' .add-class 'one column'
  if 840 < window.inner-width
    $ '#report .grid' .add-class 'four column'
  else if 480 <= window.inner-width <= 840
    $ '#report .grid' .add-class 'two  column'
  else if window.inner-width < 480
    $ '#report .grid' .add-class 'one  column'
.resize!

$.ajax do
  url: \php/get-anonymous.php
  success: ->
    for i in JSON.parse it
      append-report do
        img: i.picture1
        time: i.report_time
        region: i.region_name
        subject: i.subject_name
        content: i.content
        progress: i.progress_id
        case: i.case_id
        result-time: i.result_time
        result: i.result

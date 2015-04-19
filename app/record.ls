$ document .ready ->

  check = cookie.check!
  if check is 0 then location.href = "#{path.dirname!}login.html"
  else if check is 2 then location.href = "#{path.dirname!}error.html"

  $ \#logout .click ->
    cookie.set ''
    location.href = path.dirname!

  $.ajax do
    url: \php/get-self-report.php
    type: \POST
    data: cookie: cookie.get!
    success: ->
      it = JSON.parse it
      for i in it
        i.progress_id = parseInt i.progress_id
        tr = d3.select \tbody .append \tr
        tr.append \td
          .classed 'four wide', true
          .append \img
          .attr \src, i.picture
          .style \width, \100%
        tr.append \td
          .text i.reporttime
        tr.append \td
          .html ->
            if i.notes then notes = "(#{i.notes})" else notes = ''
            switch i.progress_id
            | 0 => "<i class='icon question'></i> 處理中"+notes
            | 1 => "<i class='icon checkmark'></i> 檢舉成功"+notes
            | 2 => "<i class='icon close'></i> 檢舉失敗"+notes
          .classed \warning, -> i.progress_id is 0
          .classed \positive, -> i.progress_id is 1
          .classed \negative, -> i.progress_id is 2
        tr.append \td
          .text (i.expect.split ' ').0

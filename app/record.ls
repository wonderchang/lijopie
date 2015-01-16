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
          .append \img
          .attr \src, i.picture
          .attr \width, 150
        tr.append \td
          .text i.reporttime
        tr.append \td
          .html ->
            switch i.progress_id
            | 0 => "<i class='icon question'></i> 處理中"
            | 1 => "<i class='icon checkmark'></i> 檢舉成功"
            | 2 => "<i class='icon close'></i> 檢舉失敗"
          .classed \warning, -> i.progress_id is 0
          .classed \positive, -> i.progress_id is 1
          .classed \negative, -> i.progress_id is 2
        tr.append \td
          .text (i.expect.split ' ').0

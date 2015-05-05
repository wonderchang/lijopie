require! <[fs mysql]>

config = JSON.parse fs.read-file-sync \../config.json, \utf8

case-list = <[1430308786]>
connection = mysql.create-connection config.mysql; connection.connect!

case-id <-! case-list.for-each
err, row <-! connection.query "SELECT * FROM report WHERE case_id='#case-id'"
if err then throw err
console.log row



function failed-report
  return ''

function successfully-report
  return ''

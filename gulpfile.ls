require! <[gulp main-bower-files gulp-concat gulp-filter gulp-jade gulp-livereload gulp-livescript gulp-markdown gulp-print gulp-rename gulp-stylus gulp-util streamqueue tiny-lr]>
require! <[phantom mysql fs utf8 quoted-printable]>
Imap = require \imap

config = JSON.parse fs.read-file-sync \config.json, \utf8
tiny-lr-port = 35729

paths =
  app: \app
  build: \public

tiny-lr-server = tiny-lr!
livereload = -> gulp-livereload tiny-lr-server

gulp.task \default <[watch]>
gulp.task \watch <[build server]> ->
  tiny-lr-server.listen tiny-lr-port, ->
    return gulp-util.log it if it
  gulp.watch paths.app+\/**/*.jade, <[html]>
  gulp.watch paths.app+\/**/*.styl, <[css]>
  gulp.watch paths.app+\/**/*.ls,   <[js]>
  gulp.watch paths.app+\/**/*.php,  <[php]>
  gulp.watch paths.app+\/res/**,    <[res]>
  gulp.watch \config.json,          <[config]>

gulp.task \build <[html css js php res config cookie crontab]>
gulp.task \server ->
  require! \express
  express-server = express!
  express-server.use require(\connect-livereload)!
  express-server.use express.static paths.build
  express-server.listen config.express.port
  gulp-util.log "[Service running]: Listening on port #{config.express.port}".yellow

gulp.task \html ->
  jade = gulp.src paths.app+\/**/*.jade .pipe gulp-jade {+pretty}
  streamqueue {+objectMode}
    .done jade
    .pipe gulp.dest paths.build
    .pipe livereload!

gulp.task \css ->
  css-bower = gulp.src main-bower-files! .pipe gulp-filter \**/*.css
  styl-app = gulp.src paths.app+\/app.styl .pipe gulp-stylus!
  streamqueue {+objectMode}
    .done css-bower, styl-app
    .pipe gulp-concat \app.css
    .pipe gulp.dest paths.build
    .pipe livereload!
  gulp.src paths.app+\/*.styl .pipe gulp-stylus!
    .pipe gulp.dest paths.build

gulp.task \js ->
  js-bower = gulp.src main-bower-files! .pipe gulp-filter \**/*.js
  ls-app = gulp.src paths.app+\/app.ls .pipe gulp-livescript {+bare}
  streamqueue {+objectMode}
    .done js-bower, ls-app
    .pipe gulp-concat \app.js
    .pipe gulp.dest paths.build
    .pipe livereload!
  gulp.src paths.app+\/*.ls .pipe gulp-livescript {+bare}
    .pipe gulp.dest paths.build
    .pipe livereload!

gulp.task \php ->
  gulp.src paths.app+\/php/**/*.php
    .pipe gulp.dest paths.build+\/php

gulp.task \res ->
  gulp.src \bower_components/semantic-ui/dist/themes/**
    .pipe gulp.dest paths.build+\/themes
  gulp.src paths.app+\/res/**
    .pipe gulp.dest paths.build+\/res

gulp.task \config ->
  str =  "<?php\n"
  str += "$test_mode = '#{config.test.mode}';\n"
  str += "$test_port = '#{config.test.port}';\n"
  str += "$test_gmail_user = '#{config.test.gmailUser}';\n"
  str += "$test_gmail_password = '#{config.test.gmailPassword}';\n"
  str += "$db_host = '#{config.mysql.host}';\n"
  str += "$db_user = '#{config.mysql.user}';\n"
  str += "$db_pass = '#{config.mysql.password}';\n"
  str += "$db_name = '#{config.mysql.database}';\n"
  str += "$report_name = '#{config.agency.name}';\n"
  str += "$report_gmail = '#{config.agency.gmail.user}';\n"
  str += "?>"
  err <-! fs.write-file paths.build+\/php/config.php, str
  if err then throw err

gulp.task \cookie ->
  if config.test.mode then return gulp-util.log '[Developing mode]: Cookie not prepared, can not really report to police'.yellow
  url = "http://www.tnpd.gov.tw/chinese/home.jsp?serno=201012130069&mserno=201012130066&menudata=TncgbMenu&contlink=ap/mail1.jsp&level2=Y"
  user-agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36"
  ph <-! phantom.create
  page <-! ph.create-page
  page.set \setting, user-agent: user-agent
  <-! page.open url
  <-! page.get-cookies
  cookie_key = it.0.name; cookie_value = it.0.value
  content <-! page.get-content

  session_file = 'session/'+(new Date! .get-time!)+'.html'

  fs.write-file paths.build+'/'+session_file, content, (err) ->
    if err then throw err

  if content is /.*<b>(\d+)<\/b>.*/
    verify_code = that.1

    data = fs.read-file-sync paths.build+\/php/db-info.php, \utf8
    connection = mysql.create-connection config.mysql; connection.connect!

    err <-! connection.query "LOCK TABLES session WRITE"
    if err then throw err

    sql  = "INSERT INTO session SET "
    sql += "session_file='#session_file', cookie_key='#cookie_key',"
    sql += "cookie_value='#cookie_value', verify_code='#verify_code',"
    sql += "create_time=now()"
    (err, rows, fields) <-! connection.query sql
    if err then throw err

    err <-! connection.query "UNLOCK TABLES"
    if err then throw err
    gulp-util.log "[Service running]: Get cookie #cookie_key=#cookie_value".yellow
    connection.end!

gulp.task \crontab <[imap]>

gulp.task \imap ->
  imap = new Imap do
    user: config.agency.gmail.user
    password: config.agency.gmail.password
    host: \imap.gmail.com
    port: 993
    tls: true
  imap.connect!
  imap.once \error, (err) -> console.log err
  imap.once \end, -> console.log 'Connection ended'
  imap.once \ready, ->
    err, box <-! imap.open-box \INBOX, true
    if err then throw err
    err, results <-! imap.search [['FROM', 'police@tnpd.gov.tw']]
    if err then throw err
    f = imap.fetch [results.2], bodies: ["HEADER.FIELDS (FROM TO SUBJECT DATE)", "TEXT"]

    f.on \message, (msg, id) ->
      prefix = "(# #id)"
      msg.on \body, (stream, info) ->
        buffer = ''
        stream.on   \data, -> buffer += str = it.to-string \utf8
        stream.once \end,  ->
          console.log \-------------------
          line = buffer / '\n'
          if line.2 is /.*Content-Transfer-Encoding: quoted-printable.*/
            console.log utf8.decode quotedPrintable.decode buffer
          else
            console.log header = Imap.parse-header buffer
      msg.once \end, -> #console.log prefix + 'Finished'
    f.once 'error', ->
      console.log "Fetch error: #{it}"
    f.once 'end',   ->
      console.log 'Done fetching all messages!'
      imap.end!

# vi:et:ft=ls:nowrap:sw=2:ts=2

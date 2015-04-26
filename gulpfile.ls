require! <[gulp main-bower-files gulp-concat gulp-filter gulp-jade gulp-livereload gulp-livescript gulp-markdown gulp-print gulp-rename gulp-stylus gulp-util streamqueue tiny-lr]>
require! <[phantom mysql fs]>

port = 9998
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
  gulp.watch paths.app+\/**/*.ls, <[js]>
  gulp.watch paths.app+\/**/*.php, <[php]>
  gulp.watch paths.app+\/res/**, <[res]>

gulp.task \build <[html css js php res]>
gulp.task \server ->
  require! \express
  express-server = express!
  express-server.use require(\connect-livereload)!
  express-server.use express.static paths.build
  express-server.listen port
  gulp-util.log "Listening on port: #port"
  get-cookie!

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

!function get-cookie

  url = "http://www.tnpd.gov.tw/chinese/home.jsp?serno=201012130069&mserno=201012130066&menudata=TncgbMenu&contlink=ap/mail1.jsp&level2=Y"
  user-agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36"

  gulp-util.log "Starting '#{'get-cookie'.cyan}'..."
  start-time = new Date! .get-time!

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
    gulp-util.log "Running  '#{'get-cookie'.cyan}' #session_file saved"

  if content is /.*<b>(\d+)<\/b>.*/
    verify_code = that.1

    data = fs.read-file-sync paths.build+\/php/db-info.php, \utf8; db = {}
    if data is /.*\$host = '(.+?)';.*/ then db.host = that.1
    if data is /.*\$user = '(.+?)';.*/ then db.user = that.1
    if data is /.*\$name = '(.+?)';.*/ then db.database = that.1
    if data is /.*\$pass = '(.+?)';.*/ then db.password = that.1
    connection = mysql.create-connection db; connection.connect!

    err <-! connection.query "LOCK TABLES session WRITE"
    if err then throw err
    gulp-util.log "Running  '#{'get-cookie'.cyan}' Lock session table writing"

    sql  = "INSERT INTO session SET "
    sql += "session_file='#session_file', cookie_key='#cookie_key',"
    sql += "cookie_value='#cookie_value', verify_code='#verify_code',"
    sql += "create_time=now()"
    (err, rows, fields) <-! connection.query sql
    if err then throw err
    gulp-util.log "Running  '#{'get-cookie'.cyan}' Insert new cookie into MySQL session table"

    err <-! connection.query "UNLOCK TABLES"
    if err then throw err
    gulp-util.log "Running  '#{'get-cookie'.cyan}' Unlock tables"
    spend = (Math.round ((new Date! .get-time!) - start-time) / 10) / 100
    gulp-util.log "Finished '#{'get-cookie'.cyan}' after #{spend.to-string!magenta} s"
    connection.end!

# vi:et:ft=ls:nowrap:sw=2:ts=2

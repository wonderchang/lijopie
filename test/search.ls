Imap = require \imap
qp = require \quoted-printable
fs = require \fs
utf8 = require \utf8

config = JSON.parse fs.read-file-sync \config.json, \utf8

imap = new Imap do
  user: config.agency.gmail.user
  password: config.agency.gmail.password
  host: \imap.gmail.com
  port: 993
  tls: true

function open-inbox cb
  imap.open-box \INBOX, true, cb

imap.once \ready, ->
  open-inbox (err, box) ->
    if err then throw err
    imap.search [/*'UNSEEN',*/ ['FROM', 'police@tnpd.gov.tw']], (err, results) ->
      if err then throw err
      f = imap.fetch [results.2], bodies: ["HEADER.FIELDS (FROM TO SUBJECT DATE)", "TEXT"]
      f.on \message, (msg, seqno) ->
        prefix = '(#' + seqno + ') '
        msg.on \body, (stream, info) ->
          buffer = ''
          stream.on 'data', -> buffer += str = it.to-string \utf8
          stream.once 'end', ->
            console.log \----------------------------------------------------------------------------------------------
            line = buffer / '\n'
            console.log line.2
            if line.2 is /.*Content-Transfer-Encoding: quoted-printable.*/
              console.log utf8.decode qp.decode buffer
            else
              console.log header = Imap.parse-header buffer
        msg.once \end, -> #console.log prefix + 'Finished'
      f.once 'error', (err) -> console.log 'Fetch error: ' + err
      f.once 'end', -> console.log 'Done fetching all messages!'; imap.end!
imap.once \error, (err) -> console.log err
imap.once \end, -> console.log 'Connection ended'
imap.connect!

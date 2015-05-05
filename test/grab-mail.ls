Imap = require \imap
qp = require \quoted-printable
fs = require \fs
utf8 = require \utf8

config = JSON.parse fs.read-file-sync \config.json, \utf8

imap = new Imap do
  user: config.user
  password: config.pass
  host: \imap.gmail.com
  port: 993
  tls: true

function open-inbox cb
  imap.open-box \INBOX, true, cb

imap.once \ready, ->
  open-inbox (err, box) ->
    if err then throw err
    f = imap.seq.fetch \1:3, do
      bodies: ["HEADER.FIELDS (FROM TO SUBJECT DATE)", "TEXT"]
      struct: true
    f.on \message, (msg, seqno) ->
      prefix = '(#' + seqno + ') '
      msg.on \body, (stream, info) ->
        buffer = ''
        stream.on 'data', (chunk) ->
          buffer += chunk.to-string \utf8
          #console.log str = utf8.decode qp.decode(chunk.to-string \utf8)
        stream.once 'end', -> console.log collect = Imap.parse-header buffer
      #msg.once \attributes, (attrs) -> console.log attrs
      msg.once \end, -> console.log prefix + 'Finished'
    f.once 'error', (err) -> console.log 'Fetch error: ' + err
    f.once 'end', -> console.log 'Done fetching all messages!'; imap.end!
imap.once \error, (err) -> console.log err
imap.once \end, -> console.log 'Connection ended'
imap.connect!

qp = require \quoted-printable
fs = require \fs
utf8 = require \utf8

data = fs.read-file-sync \mail, \utf-8

d = utf8.decode qp.decode data
console.log d

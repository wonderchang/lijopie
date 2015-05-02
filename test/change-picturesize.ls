require! <[imagemagick]>

do function ima picture ->
	imagemagick.identify ['-format', '%Wx%h', picture], (err,output) ->
		if err then throw err
		console.log output

do function resize picture ->
	im.resize [srcPath: picture,dstPath: 'test01.png',width: 256], (err, stdout, stderr) ->
		if err then throw err 
		console.log 'resized ' + ima 'test01.png'

ima 'test.png'
resize 'test.png'

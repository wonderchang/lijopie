var im = require('imagemagick');

function ima(picture) {
	im.identify(['-format', '%wx%h', picture], function(err, output){
		if (err) throw err;
		console.log(output);
	});
}
function resize(picture) {
	im.resize({
		srcPath: picture,
		dstPath: 'test01.png',
		width:   256
		}, function(err, stdout, stderr){
			if (err) throw err;
			console.log('resized '+ ima('test01.png'));
		});
}
ima('test.png');
resize('test.png');

var fs       = require('fs');
var net      = require('net');


var that = this;

this.server = net.createServer();

this.server.on('connection', function(socket) {
	var sync = fs.createReadStream('./libtest.dylib');
	
	console.log('new Connection : ', socket.remoteAddress);
	
	socket.on('error', function (err) {
		socket.end();
	});

	sync.on('error', function(e) {
	});
	sync.on('open', function() {
		sync.pipe(socket);
	});
	sync.on('finish', function() {
		socket.end();
	});
});

this.server.on('error', function (err) {
	throw err;
});

this.server.listen(1234, function() {
console.log(' Started on port : ', that.server.address().port);
});

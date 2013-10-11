/**
 * FRESHSTART
 * Ahhhhhh, fresh.
 */

var PROD_PORT = 3000;

/**
 * Module dependencies.
 */

var routes = require('./routes')
  , path = require('path')
  , util = require('util')
  , _ = require('underscore')

/**
 * Create app, server, and socket.io
 */

var express = require('express')
  , app = express()
  , server = require('http').createServer(app)
  , io = require('socket.io').listen(server);



// all environments
app.set('port', process.env.PORT || PROD_PORT);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express.cookieParser('your secret here'));
app.use(express.session());
app.use(app.router);
app.use(require('stylus').middleware(__dirname + '/public'));
app.use(express.static(path.join(__dirname, 'public')));


app.configure('development', function(){
	app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
	app.use(express.errorHandler());
	app.use(express.compress());
});

app.get('/', routes.index);


/**
 * Configure socket.io connection
 */

io.configure(function() {
	io.enable('browser client minification');
	io.enable('browser client etag');
	io.enable('browser client gzip');
	io.set('heartbeat interval', 60);
	io.set('heartbeat timeout', 120);
	io.set('log level',1);
	io.set('transports',[
		'websocket',
		'flashsocket',
		'htmlfile',
		'xhr-polling',
		'jsonp-polling'
	]);
});

/**
 * Handle socket.io events
 */

io.sockets.on('connection', function (socket) {
	
	console.log('HANDSHAKE MADE!');

	// socket.on('event', function (data){
	// 	var parsed = data.trim();
	// 	socket.emit('event complete', parsed );
	// 	});
	// });

	socket.on('ready', function(){
		console.log('Client page has loaded!')
	})
	// Useless comment just so I can change the file and test my pulls
});


/**
 * Launch the server after everything is set up.
 */

_.defer(function() {
	server.listen(app.get('port'), function(){
		console.log('Express server listening on port ' + app.get('port'));
	});
});

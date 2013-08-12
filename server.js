var connect = require('connect')
,	http = require('http')
, 	app
;

app = connect()
.use(connect.static('app'))
//.use(connect.static('backbone.marionette-atinux-books'))
.use('/js/lib/', connect.static('node_modules/requirejs/'))
.use('node_modules/', connect.static('node_modules'))
// for testing, possibly not necessary
.use('/test', connect.static('test/'))
.use('/test', connect.static('app'))
;

http.createServer(app).listen(8082, function(){
	console.log('Running on http://localhost:8082');
});

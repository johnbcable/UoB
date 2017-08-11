var uname = 'TECHADMIN6';
var pword = 'Banzai29';
var http = require('https'),

fs = require('fs');

var options = {
	ca: fs.readFileSync('hcmcert1'),
	host: 'edzz-test.hcm.em3.oraclecloud.com',
	port: 10620,
	path: '/hcmCoreApi/resources/11.12.1.0/emps/?q=PersonNumber=50000005',
	method: 'GET',
	headers: {
		'Authorization': 'Basic ' + new Buffer(uname + ':' + pword).toString('base64')
	}
};

var request = http.request(options, function(res){
	console.log(res.headers);
	var responseString = '';
	res.on('data', function(chunk) {
		console.log(chunk);
		responseString += chunk;
	});
	res.on('end', function() {
		console.log(responseString);
	})
	res.on('error', function(e) {
		console.log("Got error: " + e.message);
	});
});
request.end();

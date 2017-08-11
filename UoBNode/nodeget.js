var uname = 'TECHADMIN6';
var pword = 'Banzai29';
var http = require('https'),
fs = require('fs');
var options = {
	ca: fs.readFileSync('MyCert'),
	host: 'edzz-test.hcm.em3.oraclecloud.com',
	port: 443,
	path: '/hcmCoreApi/resources/11.12.1.0/emps',

	headers: {
		'Authorization': 'Basic ' + new Buffer(uname + ':' + pword).toString('base64')
	}
};
request = http.get(options, function(res){

	var responseString = "";

	res.on('data', function(data) {
		responseString += data;
	});

	res.on('end', function() {
		console.log(responseString);
	});

	res.on('error', function(e) {
		console.log("Got error: " + e.message);
	});

});
// https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/emps/?q=PersonNumber=50000005

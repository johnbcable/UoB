//
//	PersonComparators.js
//
//	All Javascript routines to generate provide comparison data between legacy
//  data stores and Fusion
//
//	Normally called from CheckWorker.html
//
//

function getLegacyWorkerData(personcode) {

	var url = "http://its-n-jcnc-01/UoB/dist/fetchJSON.asp?id=2";
	var myperson = personcode || 5000015;

	// var eventsfound = false;
	$.getJSON(url,function(data){

		// Now loop through returned data correcting it as required.

		// console.log(url);

		// var jsonstring = JSON.stringify(data);

		// jsonstring = new String("{allAnonymousWorkers:"+jsonstring+"}");

		// var eventdata = $.parseJSON(jsonstring);
		// var anonymousworkerdata = eval("(" + jsonstring + ")");

		// Set the boolean if we have data
		// if (eventdata.length > 1)
		//	eventsfound = true;

		// $("#receivedjson").append(jsonstring);

		// downloadDAT({ data: data, filename: "AnonymousWorker.dat" });

	});  // end of function(data)

}

// ============================================================================
function getFusionWorkerData(personcode) {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=3";
	var myperson = personcode || 5000015;

	// var eventsfound = false;
	$.getJSON(url,function(data){

		// downloadDAT({ data: data, filename: "LegislativeData.dat" });

	});  // end of function(data)

}


$(document).ready(function() {


})  // end of document.ready

//
//	Positions.js
//
//	All Javascript routines to generate all segments of a a Position.dat
//	as separate files
//
//	Normally called from Positions.html
//
//

function getAnonymousPositions() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=11";

//
//	All Javascript routines to generate all segments of a a Position.dat
//	as separate files
//
//	Normally called from Positions.html
//
//

function getAnonymousPositions() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=11";
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

		downloadDAT({ data: data, filename: "AnonymousPositions.dat" });

	});  // end of function(data)

}

$(document).ready(function() {


})  // end of document.ready

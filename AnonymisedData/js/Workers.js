<<<<<<< HEAD
//
//	Workers.js
//
//	All Javascript routines to generate all segments of a a Worker.dat
//	as separate files
//
//  http://its-n-jcnc-01/jctest/test1.asp?id=1
//	Normally called from Workers.html
//
//  METADATA|Worker|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonNumber|StartDate|DateOfBirth|ActionCode
//

function getAnonymousWorkers() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=2";
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

		downloadDAT({ data: data, filename: "AnonymousWorker.dat" });

	});  // end of function(data)

}

//
// METADATA|PersonLegislativeData|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|LegislationCode|Sex|MaritalStatus
// MERGE|PersonLegislativeData|ALTAHRN01|27332087_LEGISLATIVE|2016/07/04|4712/12/31|27332087|GB|M|M
// ============================================================================
function getLegislativeData() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=3";
		// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "LegislativeData.dat" });

	});  // end of function(data)

}

// ============================================================================
function getWorkRelationship() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=4";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "WorkRelationship.dat" });

	});  // end of function(data)

}

// ============================================================================
function getWorkTerms() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=4";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "WorkTerms.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonPhone() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=5";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonPhone.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonEmail() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=6";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonEmail.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonAddress() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=7";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "getPersonAddress.dat" });

	});  // end of function(data)

}

$(document).ready(function() {


})  // end of document.ready
=======
//
//	Workers.js
//
//	All Javascript routines to generate all segments of a a Worker.dat
//	as separate files
//
//  http://its-n-jcnc-01/jctest/test1.asp?id=1
//	Normally called from Workers.html
//
//  METADATA|Worker|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonNumber|StartDate|DateOfBirth|ActionCode
//

function getAnonymousWorkers() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=2";
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

		downloadDAT({ data: data, filename: "AnonymousWorker.dat" });

	});  // end of function(data)

}

//
// METADATA|PersonLegislativeData|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|LegislationCode|Sex|MaritalStatus
// MERGE|PersonLegislativeData|ALTAHRN01|27332087_LEGISLATIVE|2016/07/04|4712/12/31|27332087|GB|M|M
// ============================================================================
function getLegislativeData() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=3";
		// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "LegislativeData.dat" });

	});  // end of function(data)

}

// ============================================================================
function getWorkRelationship() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=4";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "WorkRelationship.dat" });

	});  // end of function(data)

}

// ============================================================================
function getWorkTerms() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=4";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "WorkTerms.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonPhone() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=5";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonPhone.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonEmail() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=6";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonEmail.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonAddress() {

	var url = "http://its-n-jcnc-01/UoB/AnonymisedData/fetchJSON.asp?id=7";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "getPersonAddress.dat" });

	});  // end of function(data)

}

$(document).ready(function() {


})  // end of document.ready
>>>>>>> 0104ec4e7ab52d8fdbcea8b9efc1d52c7c9d89f8

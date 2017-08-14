//
//	Workers.js
//
//	All Javascript routines to generate all segments of a a Worker.dat
//	as separate files
//
//	Normally called from Workers.html
//
//  METADATA|Worker|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonNumber|StartDate|DateOfBirth|ActionCode
//

function getAnonymousWorkers() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=2";
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

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=3";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "LegislativeData.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonName() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=4";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonName.dat" });

	});  // end of function(data)

}

// ============================================================================
function getWorkRelationship() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=5";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "WorkRelationship.dat" });

	});  // end of function(data)

}

// ============================================================================
function getWorkTerms() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=6";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "WorkTerms.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonPhone() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=7";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonPhone.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonEmail() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=8";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonEmail.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonAddress() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=9";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonAddress.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonAssignment() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=10";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonAssignment.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonAssignmentWithPosition() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=13";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonAssignmentWithPosition.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonEthnicity() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=12";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonEthnicity.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonDisability() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=14";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonDisability.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonReligion() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=15";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonReligion.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonNationalIdentifier() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=16";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonNationalIdentifier.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonCitizenship() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=17";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonCitizenship.dat" });

	});  // end of function(data)

}

// ============================================================================
function getPersonDisabilityBlanks() {

	var url = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=50";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonDisabilityBlanks.dat" });

	});  // end of function(data)

}

$(document).ready(function() {


})  // end of document.ready

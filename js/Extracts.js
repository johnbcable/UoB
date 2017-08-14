//
//	Positions.js
//
//	All Javascript routines to extrcat already loaded data from an
//	Oracle POD.
//
//	Normally called from Positions.html
//
//  METADATA|Worker|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonNumber|StartDate|DateOfBirth|ActionCode
//

function getLoadedLocations() {

	var summarylocationdata = new Array();
	var summarylocationobject = new Object();

	var url = "https://edzz-test.hcm.em3.oraclecloud.com//hcmCoreSetupApi/resources/11.12.1.0/locations";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		// Now loop through returned data correcting it as required.

		var jsonstring = JSON.stringify(data);

		jsonstring = new String("{allLocations:"+jsonstring+"}");

		// var eventdata = $.parseJSON(jsonstring);
		var locationdata = eval("(" + jsonstring + ")");

		// Now need to accumulate summary data from fixturedata

		// Loop through fixturedata
		$.each(locationdata, function () {
		   $.each(this, function () {
				 	var singlelocation = new Object();
		   		singlelocation.LocationId = this.LocationId;
					singlelocation.LocationCode = this.LocationCode;
					singlelocation.LocationName = this.LocationName;

					summarylocationdata.push(singlelocation);

					singlelocation = null;

		   });
		});


		// console.log(url);

		// var jsonstring = JSON.stringify(data);

		// jsonstring = new String("{allAnonymousWorkers:"+jsonstring+"}");

		// var eventdata = $.parseJSON(jsonstring);
		// var anonymousworkerdata = eval("(" + jsonstring + ")");

		// Set the boolean if we have data
		// if (eventdata.length > 1)
		//	eventsfound = true;

		// $("#receivedjson").append(jsonstring);

		downloadDAT({ data: summarylocationdata, filename: "SummaryLocations.dat" });

	});  // end of function(data)

}

//
// METADATA|PersonLegislativeData|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|LegislationCode|Sex|MaritalStatus
// MERGE|PersonLegislativeData|ALTAHRN01|27332087_LEGISLATIVE|2016/07/04|4712/12/31|27332087|GB|M|M
// ============================================================================
function getLoadedJobs() {

	var url = "https://edzz-test.hcm.em3.oraclecloud.com//hcmCoreSetupApi/resources/11.12.1.0/jobs";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "LegislativeData.dat" });

	});  // end of function(data)

}

// ============================================================================
function getLoadedOrganizations() {

	var url = "https://edzz-test.hcm.em3.oraclecloud.com//hcmCoreSetupApi/resources/11.12.1.0/organizations";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		downloadDAT({ data: data, filename: "PersonName.dat" });

	});  // end of function(data)

}


$(document).ready(function() {


})  // end of document.ready

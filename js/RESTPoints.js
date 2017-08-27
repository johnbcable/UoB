//
//	RESTPoints.js
//
//	All Javascript routines to generate all segments of a a Worker.dat
//	as separate files
//
//	Normally called from RESTPoints.asp
//
//  Global variables
//


var baseCoreURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";
var baseSetupURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreSetupApi/resources/11.12.1.0/";
var legacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=49";
var jsonstring;

// Utility functions

// Register Handlebars helpers

Handlebars.registerHelper('equalsTo', function(v1, v2, options) {
    if(v1 == v2) { return options.fn(this); }
    else { return options.inverse(this); }
});



// ============================================================================
function getGrades(filetype) {

	var url = baseSetupURL +"grades?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#fusionjsonheader').html('<h1>All Grades</h1>');

			$('#fusionreceivedjson').html(jsonstring);

  		if (generatedfiletype == 'DAT') {
				console.log("DAT file chosen");
				downloadDAT({ data: data.items, filename: "Grade.dat" });
			}
			if (generatedfiletype == 'CSV') {
				console.log("CSV file chosen");
				downloadCSV({ data: data.items, filename: "Grade.csv" });
			}

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}

// ============================================================================
function getJobs(filetype) {

	var url = baseSetupURL +"jobs?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#fusionjsonheader').html('<h1>All Jobs</h1>');

			$('#fusionreceivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
 				console.log("DAT file chosen");
 				downloadDAT({ data: data.items, filename: "Job.dat" });
 			}
 			if (generatedfiletype == 'CSV') {
 				console.log("CSV file chosen");
 				downloadCSV({ data: data.items, filename: "Job.csv" });
 			}

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}

// ============================================================================
function getPositions(filetype) {

	var url = baseSetupURL +"positions?onlyData&limit=30000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#fusionjsonheader').html('<h1>All Positions</h1>');

			$('#fusionreceivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: "Position.dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename: "Position.csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}


// ============================================================================
function getJobFamilies(filetype) {

	var url = baseSetupURL +"jobFamilies?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#fusionjsonheader').html('<h1>All Job Families</h1>');

			$('#fusionreceivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: "JobFamily.dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename: "JobFamily.csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}


// ============================================================================
function getLocations(filetype) {

	var url = baseSetupURL +"locations?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#fusionjsonheader').html('<h1>All Locations</h1>');

			$('#fusionreceivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: "Location.dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename: "Location.csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}

// ============================================================================
function getOrganisations(orgtype, filetype) {

	var myorgtype = orgtype || 'DEPARTMENT';
	var url = baseSetupURL +"organizations?onlyData&limit=1000&q=ClassificationCode="+myorgtype;
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#fusionjsonheader').html('<h1>All Organisations of Classification '+myorgtype+'</h1>');

			$('#fusionreceivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: myorgtype+".dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename:  myorgtype+".csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}

// ============================================================================
function getFusionEmployee(personcode) {

	var myperson = personcode || '5500165';
	var url = baseCoreURL + "emps?onlyData&limit=10&q=PersonNumber=" + myperson;
	var fusionemployee = {};
	var myfusion = {};

	console.log(url);

	// var eventsfound = false;
	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data.items);
			jsonstring = new String("{fusionemployees:"+jsonstring+"}");
			// fusionemployee = JSON.parse(jsonstring);

			// jsonstring = new String('{"fusiondata:"' + jsonstring + '}').toString();
	    // console.log("Legacy jsonstring: "+jsonstring);

 			fusionemployeedata = eval("(" + jsonstring + ")");

			// get HTML for the display template in the script tag
			var theTemplateScript = $("#fusionlist-template").html();

			// Compile the Handlebars template
			var theTemplate = Handlebars.compile(theTemplateScript);

			// Clear out the display area
			$("#main").empty();
			$("#main").append(theTemplate(fusionemployeedata));

				console.log(data.items[0].Salutation, data.items[0].FirstName);

 			$('#fusionjsonheader').html('<h1>Fusion Employee Details for '+myperson+'</h1>');

			$('#fusionreceivedjson').html(jsonstring);

		/*
				Title=data.items[0].Salutation;
				Forename=data.items[0].FirstName;
				Surname=data.items[0].LastName;
				PreferredName=data.items[0].PreferredName;
				PersonCode=data.items[0].PersonNumer;
				HomeTelephone=data.items[0].HomePhoneNumber;
				WorksEmailAddress=data.items[0].WorkEmail;
				AddressLine1=data.items[0].AddressLine1;
				AddressLine2=data.items[0].AddressLine2;
				AddressLine3=data.items[0].AddressLine3;
				Town=data.items[0].City;
				Region=data.items[0].Region;
				Country=data.items[0].Country;
				Postcode=data.items[0].PostalCode;
				DateOfBirth=data.items[0].DateOfBirth;
				EthnicOriginDescription=data.items[0].Ethnicity;
				Gender=data.items[0].Gender;
				NINumber=data.items[0].NationalId;
				UserName=data.items[0].UserName;
		}

			*/

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
			return (null);
		}

	});  // end of ajax call

  return new Object(myfusion);

}

// ============================================================================
function getLegacyEmployee(personcode) {

	var myperson = personcode || '5500165';
	var url = legacyURL + "&p1=";
	var legacyemployee = {};

	url += myperson;

	console.log(url);

	// var eventsfound = false;
	$('#legacyjsonheader').html('');
	$('#flegacyreceivedjson').html('');

	$.getJSON(url, function (data) {

		// console.log("Legacy url: "+url);

		var jsonstring = JSON.stringify(data);

		// jsonstring = new String('{"legacydata:"' + jsonstring + '}').toString();
    // console.log("Legacy jsonstring: "+jsonstring);

		legacyemployee = JSON.parse(jsonstring);
		// legacyemployee = eval("(" + jsonstring + ")");

		$('#legacyjsonheader').html('<h1>Legacy Employee Details for '+myperson+'</h1>');

		$('#legacyreceivedjson').html(jsonstring);

	});  // end of getJSON call

	/*

	function myfunc() {
	   return {"name": "bob", "number": 1};
	}

	var myobj = myfunc();
	console.log(myobj.name, myobj.number); // logs "bob 1"

	*/

	/*
	mylegacy = {
		title: new String(legacydata.legacydata[0].Title).toString();
		forename: new String(legacydata.legacydata[0].Forename).toString();
		surname: new String(legacydata.legacydata[0].LastName).toString();
		preferredName: new String(legacydata.legacydata[0].PreferredName).toString();
		personCode: new String(legacydata.legacydata[0].PersonCode).toString();
		homeTelephone: new String(legacydata.legacydata[0].HomeTelephone).toString();
		worksEmailAddress: new String(legacydata.legacydata[0].AnonymisedWorkEmail).toString();
		addressLine1: new String(legacydata.legacydata[0].AddressLine1).toString();
		addressLine2: new String(legacydata.legacydata[0].AddressLine2).toString();
		addressLine3: new String(legacydata.legacydata[0].AddressLine3).toString();
		town: new String(legacydata.legacydata[0].Town).toString();
		region: new String(legacydata.legacydata[0].Region).toString();
		country: new String(legacydata.legacydata[0].Country).toString();
		postcode: new String(legacydata.legacydata[0].Postcode).toString();
		dateOfBirth: new String(legacydata.legacydata[0].DateOfBirth).toString();
		ethnicOriginDescription: new String(legacydata.legacydata[0].EthnicOriginDescription).toString();
		gender: new String(legacydata.legacydata[0].Gender).toString();
		nINumber: new String(legacydata.legacydata[0].NINumber).toString();
		userName: new String(legacydata.legacydata[0].UserName).toString();
	};
	*/

	return(legacyemployee);

}



$(document).ready(function() {

/*

function myfunc() {
   return {"name": "bob", "number": 1};
}

var myobj = myfunc();
console.log(myobj.name, myobj.number); // logs "bob 1"

*/

	// ===========================================
	// Employee

	$('#personcomparator').click( function(event) {
		event.preventDefault();
		var myemp = $('#personcode').val();
		myemp = myemp || 5500165;
		// fusionreturn = new String(getFusionEmployee(myemp)).toString();
		// console.log("fusionreturn");
		// console.log(fusionreturn);
		var myfusionemployee = getFusionEmployee(myemp);   // defaults to employee 5500165
		var mylegacyemployee = getLegacyEmployee(myemp);   // defualts to employee 5500165
		console.log(myfusionemployee.forename);
		// console.log(mylegacyemployee[0].Surname);
	});


	// ===========================================
	// Grades

	$('#allgradeslink').click( function(event) {
		event.preventDefault();
		getGrades();
	});

	$('#allgradesdat').click( function(event) {
		event.preventDefault();
		getGrades('DAT');
	});

	$('#allgradescsv').click( function(event) {
		event.preventDefault();
		getGrades('CSV');
	});

	// ===========================================
	// Job Families

	$('#alljobfamilieslink').click( function(event) {
		event.preventDefault();
		getJobFamilies();
	});

	$('#alljobfamiliesdat').click( function(event) {
		event.preventDefault();
		getJobFamilies('DAT');
	});

	$('#alljobfamiliescsv').click( function(event) {
		event.preventDefault('CSV');
		getJobFamilies();
	});

	// ===========================================
	// Jobs

	$('#alljobslink').click( function(event) {
		event.preventDefault();
		getJobs();
	});

	$('#alljobsdat').click( function(event) {
		event.preventDefault();
		getJobs('DAT');
	});

	$('#alljobscsv').click( function(event) {
		event.preventDefault();
		getJobs('CSV');
	});

	// ===========================================
	// Positions
	$('#allpositionslink').click( function(event) {
		event.preventDefault();
		getPositions();
	});

	$('#allpositionsdat').click( function(event) {
		event.preventDefault();
		getPositions('DAT');
	});

	$('#allpositionscsv').click( function(event) {
		event.preventDefault();
		getPositions('CSV');
	});

	// ===========================================
	// Locations
	$('#alllocationslink').click( function(event) {
		event.preventDefault();
		getLocations();
	});

	$('#alllocationsdat').click( function(event) {
		event.preventDefault();
		getLocations('DAT');
	});

	$('#alllocationscsv').click( function(event) {
		event.preventDefault();
		getLocations('CSV');
	});

	// ===========================================
	// Organizations
	// 1. Departments
	$('#allorganizationslink').click( function(event) {
		event.preventDefault();
		getOrganisations('DEPARTMENT');
	});

	$('#allorganizationsdat').click( function(event) {
		event.preventDefault();
		getOrganisations('DEPARTMENT','DAT');
	});

	$('#allorganizationscsv').click( function(event) {
		event.preventDefault();
		getOrganisations('DEPARTMENT','CSV');
	});

	// 2. Divisions
	$('#alldivisionslink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_DIVISION');
	});

	$('#alldivisionsdat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_DIVISION','DAT');
	});

	$('#alldivisionscsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_DIVISION','CSV');
	});

	// 3. Payroll Statutory Units
	$('#allpsulink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_PSU');
	});

	$('#allpsudat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_PSU','DAT');
	});

	$('#allpsucsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_PSU','CSV');
	});

	// 4. Tax Reporting Unit
	$('#alltrulink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_TRU');
	});

	$('#alltrudat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_TRU','DAT');
	});

	$('#alltrucsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_TRU','CSV');
	});

	// 5. Legal Reporting Unit
	$('#alllrulink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LRU');
	});

	$('#alllrudat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LRU','DAT');
	});

	$('#alllrucsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LRU','CSV');
	});

	// 6. Legal Employer
	$('#alllemplink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LEMP');
	});

	$('#alllempdat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LEMP','DAT');
	});

	$('#alllempcsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LEMP','CSV');
	});

	// 7. Reporting Establishment
	$('#allrelink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_REPORTING_ESTABLISHMENT');
	});

	$('#allredat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_REPORTING_ESTABLISHMENT','DAT');
	});

	$('#allrecsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_REPORTING_ESTABLISHMENT','CSV');
	});

})  // end of document.ready

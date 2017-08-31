//
//	CheckWorker.js
//
//	All Javascript routines to generate all segments of a a Worker.dat
//	as separate files
//
//	Normally called from CheckWorker.asp
//
//  Global variables
//         legacysource:   from submitting form - will determine which legacy query to run.
//				 fusionsource:	 eventually from submitting form to determine which Fusion environment
//                         to go to for the employee information. Contsant at DEV URL's for now.
//         legacyqueryid:   for selecting which query to run. Dependent on legacysource.
//

var fusionCoreSuffix = "/hcmCoreApi/resources/11.12.1.0/";
var defaultlegacyqueryid = "?id=49";
var baseCoreURL = "https://edzz-test.hcm.em3.oraclecloud.com" + fusionCoreSuffix;
var baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp";
var fusionBaseURL = "https://edzz-test.hcm.em3.oraclecloud.com" + fusionCoreSuffix;
var legacyBaseURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp";

baseLegacyURL += defaultlegacyqueryid;

// ============================================================================
function paramSetup(personcode) {
	// Construct base Fusion url
	baseCoreURL = fusionBaseURL + fusionCoreSuffix;
	baseLegacyURL = legacyBaseURL + defaultlegacyqueryid;
}

// ============================================================================
function generateEmployeeComparisonTable(personcode) {

  	var myperson = personcode || '5500165';
	  var fusionurl = baseCoreURL + "emps?onlyData&limit=10&q=PersonNumber=";
	  var legacyurl = baseLegacyURL + "&p1=";
  	var nullobjectstring = "{}";
  	var nullobject = {};
		var thefusionemployee = {};
		var thelegacyemployee = {};

		paramSetup(myperson);

	legacyurl += myperson;
  	fusionurl += myperson;

	console.log(legacyurl);
  	console.log(fusionurl);

	// blank out raw JSON divs
	$('#legacyjsonheader').html('');
	$('#legacyreceivedjson').html('');
  	$('#fusionjsonheader').html('');
	$('#fusionreceivedjson').html('');

	// Get legacy data first
	var jsonstring;			// Used for legacy employee data
	var jsonstring2;		// Used for Fusion employee data

	$.getJSON(legacyurl, function (data) {

		// console.log("Legacy url: "+url);

		jsonstring = JSON.stringify(data[0]);

		// jsonstring = new String('{"legacydata:"' + jsonstring + '}').toString();
    	console.log("Legacy jsonstring: "+jsonstring);

		thelegacyemployee =JSON.parse(jsonstring);

		// Now issue AJAX call to get fusion employee details
		$.ajax({
			type: "GET",
			url: fusionurl,
			dataType: "json",
			headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
			success: function(data) {
				jsonstring2 = JSON.stringify(data.items[0]);

		    console.log("Fusion jsonstring2: "+jsonstring2);

				thefusionemployee =JSON.parse(jsonstring2);

				// Now reinitialise comparator object
				// Look through legacy and fusion data filling in differences
				// in comparator object
				var comparison = {};

/*
Fusion

{"Title":"MRS.","Forename":"Keira","Surname":"Grobstein","PreferredName":null,"PersonNumber":5500165,"HomePhoneNumber":null,"WorkEmail":"e.grobstein@yopmail.com","AddressLine1":"55 Tagwell Road","AddressLine2":null,"AddressLine3":null,"City":"Droitwich","Region":"Worcestershire","Country":null,"PostalCode":"WR9 7AQ","DateOfBirth":"1971-04-26","Ethnicity":"White-British","Gender":"F","NationalId":"NX707818A","UserName":"QUEENNM"}

Legacy

{"Title":"MRS.","Forename":"Keira","Surname":"Grobstein","PreferredName":null,"PersonNumber":5500165,"HomePhoneNumber":null,"WorkEmail":"e.grobstein@yopmail.com","AddressLine1":"55 Tagwell Road","AddressLine2":null,"AddressLine3":null,"City":"Droitwich","Region":"Worcestershire","Country":null,"PostalCode":"WR9 7AQ","DateOfBirth":"1971-04-26","Ethnicity":"White-British","Gender":"F","NationalId":"NX707818A","UserName":"QUEENNM"}

*/
				comparison.Title = thefusionemployee.Salutation == thelegacyemployee.Title ? "OK" : "Titles differ";
				comparison.Forename = thefusionemployee.FirstName == thelegacyemployee.Forename ? "OK" : "Forenames differ";
				comparison.Surname = thefusionemployee.LastName == thelegacyemployee.Surname ? "OK" : "Surnames differ";
				comparison.Preferredname = thefusionemployee.PreferredName == thelegacyemployee.PreferredName ? "OK" : "Preferred names differ";
				comparison.PersonCode = thefusionemployee.PersonNumber == thelegacyemployee.PersonNumber ? "OK" : "Person ID's differ";
				comparison.HomeTelephone = thefusionemployee.HomeTelephone == thelegacyemployee.HomePhoneNumber ? "OK" : "Home telephone numbers differ";
				comparison.WorkEmail = thefusionemployee.WorkEmail == thelegacyemployee.WorkEmail ? "OK" : "Titles differ";

				//  Now do checks on address components
				var addressmessage = "";
				addressmessage += thefusionemployee.AddressLine1 == thelegacyemployee.AddressLine1 ? "" : " line 1 different,";
				addressmessage += thefusionemployee.AddressLine2 == thelegacyemployee.AddressLine2 ? "" : " line 2 different,";
				addressmessage += thefusionemployee.AddressLine3 == thelegacyemployee.AddressLine3 ? "" : " line 3 different,";
				addressmessage += thefusionemployee.Town == thelegacyemployee.Town ? "" : " town different,";
				addressmessage += thefusionemployee.Region == thelegacyemployee.Region ? "" : " region different,";
				addressmessage += thefusionemployee.Country == thelegacyemployee.Country ? "" : " country different,";
				addressmessage += thefusionemployee.PostalCode == thelegacyemployee.PostalCode ? "" : " postcode different,";

				/*
				var dummy1 = new String(thefusionemployee.AddressLine1+thefusionemployee.AddressLine2+thefusionemployee.AddressLine3+thefusionemployee.Town+thefusionemployee.Region+thefusionemployee.Country+thefusionemployee.PostalCode);
				var dummy2 = new String(thelegacyemployee.AddressLine1+thelegacyemployee.AddressLine2+thelegacyemployee.AddressLine3+thelegacyemployee.Town+thelegacyemployee.Region+thelegacyemployee.Country+thelegacyemployee.PostalCode);
				*/

				comparison.Address = addressmessage == "" ? "OK" : "Addresses differ:"+addressmessage;
				// End of address components checks

				comparison.DateOfBirth = thefusionemployee.DateOfBirth == thelegacyemployee.DateOfBirth ? "OK" : "Dates of birth differ";
				comparison.Ethnicity = thefusionemployee.Ethnicity == thelegacyemployee.Ethnicity ? "OK" : "Ethnicities differ";
				comparison.Gender = thefusionemployee.Gender == thelegacyemployee.Gender ? "OK" : "Genders differ";
				comparison.NINumber = thefusionemployee.NationalID == thelegacyemployee.NationalID ? "OK" : "National Insurance numbers differ";
				comparison.UserName = thefusionemployee.UserName == thelegacyemployee.UserName ? "OK" : "Usernames differ";

				// End of creating comparator object

				$('#legacyjsonheader').html('<h1>Legacy Employee Details for '+myperson+'</h1>');
				$('#fusionjsonheader').html('<h1>Fusion Employee Details for '+myperson+'</h1>');

				$('#legacyreceivedjson').html(jsonstring);
				$('#fusionreceivedjson').html(jsonstring2);

					// Now try and fill out Handlebars template table
					var context = {
							model: thefusionemployee,
							other: thelegacyemployee,
							comparison: comparison
					};

					var theTemplateScript = $("#comparator-template").html();
					// console.log(theTemplateScript);

					var theTemplate = Handlebars.compile(theTemplateScript);
					console.log("After compile");

					// Clear out the display area
					$("#main").empty();
					$("#main").append(theTemplate(context));

			},
			error: function(xhr, textStatus, errorThrown) {
				$('#error').html(xhr.responseText);
				return (null);
			}

		});  // end of ajax call


  });
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
	    var thelegacyemployee = "";
	    var thefusionemployee = "";

		myemp = myemp || 5500165;
		// fusionreturn = new String(getFusionEmployee(myemp)).toString();
		// console.log("fusionreturn");
		// console.log(fusionreturn);

	    /*
	    thefusionemployee = getFusionEmployee(myemp);   // defaults to employee 5500165
	    console.log("The fusion employee string is: ");
	    console.log(thefusionemployee);
	    */
	    generateEmployeeComparisonTable(myemp);

			/*
	    thelegacyemployee = getLegacyEmployee(myemp);   // defualts to employee 5500165
	    console.log("The legacy employee string is: ");
	    console.log(thelegacyemployee);
	    */

	    // Data now in globals - create local context
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
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

var defaultlegacyqueryid = "?id=49";
var baseCoreURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";
var baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp";
var curperson = 5500165;
var debugging = true;

baseLegacyURL += defaultlegacyqueryid;

// ============================================================================
function paramSetup(personcode) {

	var whichlegacy;
	var whichfusion;
	var debugchoice;

	// Re-initialise globals
	curperson = 0;

	// Fetch parameters from CheckWorker.asp form
	curperson = $('#personcode').val();
	whichlegacy = $('#legacysystem').val();
	whichfusion = $('#targetsystem').val();
	debugchoice = $('#debugmode').val();

	// Establish debugging mode
	if ( debugchoice == "Y" ) {
		debugging = true;
	} else {
		debugging=false;
	}
	debugwrite("Values from CheckWorker form before any checks or defaults applied:");
	debugwrite(curperson);
	debugwrite(whichlegacy);
	debugwrite(whichfusion);
	debugwrite(debugchoice);

	var thelegacyemployee = "";
	var thefusionemployee = "";

	curperson = curperson || 5500165;

	// Construct appropriate starting Fusion url
	baseCoreURL = "https://"+whichfusion+".hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";

	// Construct appropriate starting legacy URL
	if ( whichlegacy == "ACCESS") {
		baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=49";
	}
	if ( whichlegacy == "ALTAHRN") {
		baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchALTA.asp?id=1";
	}

	// Adjust URLs to reflect submitted person code (in curperson)

}
// ============================================================================
function debugwrite(text) {
	if ( debugging ) {
		console.log(text);
	}
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

		debugwrite("Calling paramSetup");
		paramSetup(myperson);
		debugwrite("After paramSetup");

		legacyurl += myperson;
  	fusionurl += myperson;

	// debugwrite(legacyurl);
  // debugwrite(fusionurl);

	// blank out raw JSON divs even if not in debug mode to clear screen
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
    // debugwrite("Legacy jsonstring: "+jsonstring);

		thelegacyemployee =JSON.parse(jsonstring);

		// Now issue AJAX call to get fusion employee details
		$.ajax({
			type: "GET",
			url: fusionurl,
			dataType: "json",
			headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
			success: function(data) {
				jsonstring2 = JSON.stringify(data.items[0]);

		    // debugwrite("Fusion jsonstring2: "+jsonstring2);

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
				comparison.Title = thefusionemployee.Salutation == thelegacyemployee.TITLE ? "OK" : "Titles differ";
				comparison.Forename = thefusionemployee.FirstName == thelegacyemployee.FORENAME ? "OK" : "Forenames differ";
				comparison.Surname = thefusionemployee.LastName == thelegacyemployee.SURNAME ? "OK" : "Surnames differ";
				comparison.Preferredname = thefusionemployee.PreferredName == thelegacyemployee.PREFERREDNAME ? "OK" : "Preferred names differ";
				comparison.PersonCode = thefusionemployee.PersonNumber == thelegacyemployee.PERSONNUMBER ? "OK" : "Person ID's differ";
				comparison.HomeTelephone = thefusionemployee.HomeTelephone == thelegacyemployee.HOMEPHONENUMBER ? "OK" : "Home telephone numbers differ";
				comparison.WorkEmail = thefusionemployee.WorkEmail == thelegacyemployee.WORKEMAIL ? "OK" : "Titles differ";

				//  Now do checks on address components
				var addressmessage = "";
				addressmessage += thefusionemployee.AddressLine1 == thelegacyemployee.ADDRESSLINE1 ? "" : " line 1 different,";
				addressmessage += thefusionemployee.AddressLine2 == thelegacyemployee.ADDRESSLINE2 ? "" : " line 2 different,";
				addressmessage += thefusionemployee.AddressLine3 == thelegacyemployee.ADDRESSLINE3 ? "" : " line 3 different,";
				addressmessage += thefusionemployee.City == thelegacyemployee.CITY ? "" : " town different,";
				addressmessage += thefusionemployee.Region == thelegacyemployee.REGION ? "" : " region different,";
				addressmessage += thefusionemployee.Country == thelegacyemployee.COUNTRY ? "" : " country different,";
				addressmessage += thefusionemployee.PostalCode == thelegacyemployee.POSTALCODE ? "" : " postcode different,";

				/*
				var dummy1 = new String(thefusionemployee.AddressLine1+thefusionemployee.AddressLine2+thefusionemployee.AddressLine3+thefusionemployee.Town+thefusionemployee.Region+thefusionemployee.Country+thefusionemployee.PostalCode);
				var dummy2 = new String(thelegacyemployee.AddressLine1+thelegacyemployee.AddressLine2+thelegacyemployee.AddressLine3+thelegacyemployee.Town+thelegacyemployee.Region+thelegacyemployee.Country+thelegacyemployee.PostalCode);
				*/

				comparison.Address = addressmessage == "" ? "OK" : "Addresses differ:"+addressmessage;
				// End of address components checks

				comparison.DateOfBirth = thefusionemployee.DateOfBirth == thelegacyemployee.DATEOFBIRTH ? "OK" : "Dates of birth differ";
				comparison.Ethnicity = thefusionemployee.Ethnicity == thelegacyemployee.ETHNICITY ? "OK" : "Ethnicities differ";
				comparison.Gender = thefusionemployee.Gender == thelegacyemployee.GENDER ? "OK" : "Genders differ";
				comparison.NINumber = thefusionemployee.NationalId == thelegacyemployee.NATIONALID ? "OK" : "National Insurance numbers differ";
				comparison.UserName = thefusionemployee.UserName == thelegacyemployee.USERNAME ? "OK" : "Usernames differ";

				// End of creating comparator object

				if ( debugging ) {
					$('#legacyjsonheader').html('<h1>Legacy Employee Details for '+myperson+'</h1>');
					$('#fusionjsonheader').html('<h1>Fusion Employee Details for '+myperson+'</h1>');

					$('#legacyreceivedjson').html(jsonstring);
					$('#fusionreceivedjson').html(jsonstring2);
				}

					// Now try and fill out Handlebars template table
					var context = {
							model: thefusionemployee,
							other: thelegacyemployee,
							comparison: comparison
					};

					var theTemplateScript = $("#comparator-template").html();
					// console.log(theTemplateScript);

					var theTemplate = Handlebars.compile(theTemplateScript);
					debugwrite("After compile");

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

		// Set up parameters for the two queries

		paramSetup();

		// fusionreturn = new String(getFusionEmployee(myemp)).toString();
		// console.log("fusionreturn");
		// console.log(fusionreturn);

	    /*
	    thefusionemployee = getFusionEmployee(myemp);   // defaults to employee 5500165
	    console.log("The fusion employee string is: ");
	    console.log(thefusionemployee);
	    */
	    generateEmployeeComparisonTable(curperson);

			/*
	    thelegacyemployee = getLegacyEmployee(myemp);   // defualts to employee 5500165
	    console.log("The legacy employee string is: ");
	    console.log(thelegacyemployee);
	    */

	    // Data now in globals - create local context
	});


})  // end of document.ready

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
var comparisonSummary = new Array();
// var singleComparison = {};

// baseLegacyURL += defaultlegacyqueryid;

// ============================================================================
function debugwrite(text) {
	if ( debugging ) {
		console.log(text);
	}
}

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
		baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp";
	}
	if ( whichlegacy == "ALTAHRN") {
		baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchALTA.asp";
	}

	// Adjust URLs to reflect submitted person code (in curperson)

}

// ============================================================================
function generateEmployeeComparisonTable(personcode) {

  	var myperson = personcode || '5500165';
	  var fusionurl = baseCoreURL + "emps?onlyData&limit=10&q=PersonNumber=";
	  var legacyurl = baseLegacyURL + "?id=49&p1=";
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

					// Now fill out Handlebars template table
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

// ============================================================================
function compareEmployee(personcode) {

  	var myperson = personcode || '5500165';
	  var fusionurl = baseCoreURL + "emps?onlyData&limit=10&q=PersonNumber=";
	  var legacyurl = baseLegacyURL + "?id=49&p1=";
  	var nullobjectstring = "{}";
  	var nullobject = {};
		var summarylength = 0;
		var fusion = {};
		var legacy = {};

		// debugwrite("Inside compareEmployee at setup time");

		legacyurl += myperson;
  	fusionurl += myperson;

	// Get legacy data first
	var jsonstring;			// Used for legacy employee data
	var jsonstring2;		// Used for Fusion employee data

	$.getJSON(legacyurl, function (data) {

		// console.log("Legacy url: "+url);

		jsonstring = JSON.stringify(data[0]);

		// jsonstring = new String('{"legacydata:"' + jsonstring + '}').toString();
    // debugwrite("Legacy jsonstring: "+jsonstring);

		legacy = JSON.parse(jsonstring);

		// Now issue AJAX call to get fusion employee details
		$.ajax({
			type: "GET",
			url: fusionurl,
			dataType: "json",
			headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
			success: function(data) {
				jsonstring2 = JSON.stringify(data.items[0]);

		    // debugwrite("Fusion jsonstring2: "+jsonstring2);

				fusion = JSON.parse(jsonstring2);

				// Now reinitialise comparator object
				// Look through legacy and fusion data filling in differences
				// in comparator object
				var comparison = {};

				comparison.PersonID = legacy.PERSONNUMBER;

				comparison.Title = fusion.Salutation == legacy.TITLE ? "Y" : "N";
				comparison.Forename = fusion.FirstName == legacy.FORENAME ? "Y" : "N";
				comparison.Surname = fusion.LastName == legacy.SURNAME ? "Y" : "N";
				comparison.Preferredname = fusion.PreferredName == legacy.PREFERREDNAME ? "Y" : "N";
				comparison.PersonCode = fusion.PersonNumber == legacy.PERSONNUMBER ? "Y" : "N";
				comparison.HomeTelephone = fusion.HomeTelephone == legacy.HOMEPHONENUMBER ? "Y" : "N";
				comparison.WorkEmail = fusion.WorkEmail == legacy.WORKEMAIL ? "Y" : "N";

				//  Now do checks on address components
				var addressmessage = "";
				addressmessage += fusion.AddressLine1 == legacy.ADDRESSLINE1 ? "" : " line 1 different,";
				addressmessage += fusion.AddressLine2 == legacy.ADDRESSLINE2 ? "" : " line 2 different,";
				addressmessage += fusion.AddressLine3 == legacy.ADDRESSLINE3 ? "" : " line 3 different,";
				addressmessage += fusion.City == legacy.CITY ? "" : " town different,";
				addressmessage += fusion.Region == legacy.REGION ? "" : " region different,";
				addressmessage += fusion.Country == legacy.COUNTRY ? "" : " country different,";
				addressmessage += fusion.PostalCode == legacy.POSTALCODE ? "" : " postcode different,";

				comparison.Address = addressmessage == "" ? "Y" : "N";
				// End of address components checks

				comparison.DateOfBirth = fusion.DateOfBirth == legacy.DATEOFBIRTH ? "Y" : "N";
				comparison.Ethnicity = fusion.Ethnicity == legacy.ETHNICITY ? "Y" : "N";
				comparison.Gender = fusion.Gender == legacy.GENDER ? "Y" : "N";
				comparison.NINumber = fusion.NationalId == legacy.NATIONALID ? "Y" : "N";
				comparison.UserName = fusion.UserName == legacy.USERNAME ? "Y" : "N";

				// debugwrite(comparison);

				// Add this comparison as an new item to the compariusonSummary array?
				// Or do in calling function?

				summarylength = comparisonSummary.push(comparison);

			},
			error: function(xhr, textStatus, errorThrown) {
				$('#error').html(xhr.responseText);
				return (null);
			}

		});  // end of ajax call


  });
}


$(document).ready(function() {

	// ===========================================
	// Single Employee Comparison

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

	// ===========================================
	// Comparison Spreadsheet

	$('#comparisonspreadsheet').click( function(event) {
		event.preventDefault();

		// Set up parameters for this run.

		paramSetup();

		comparisonSummary = [];

		var summarylength = 0;
		var peopleList = new Array();

		console.log(debugging ?  "We are in debug mode" : "We are in live mode");

		// Pick up list of people to look at
		//

		var peopleList = new Array();

		if (!debugging)
		{
			var legacyurl = baseLegacyURL + "?id=48";
			console.log(legacyurl);
			$.getJSON(legacyurl, function (legacydata) {
				// console.log("Data returned from getJSON call to legacy URL");
				// console.log(data);

				var jsonstring = JSON.stringify(legacydata);

				jsonstring = new String("{allPeople:"+jsonstring+"}");

				var peopledata = eval("("+jsonstring+")");

				// Set up array with list of person IDs

				$.each(peopledata, function() {
				  $.each(this, function() {
				    summarylength = peopleList.push(this.PersonCode);
				  });
				});
			});
		}
		else
		{
			 peopleList = [5500018, 5500215, 5500165, 6704306];
		}

		console.log("List of people");
		console.log(peopleList);

		// Now loop through the set of people comparing each one and adding to resultset
		for (var i=0; i < peopleList.length; i++) {
			console.log("Comparing employee "+peopleList[i]);
			compareEmployee(peopleList[i]);
		}

		if ( debugging ) {
				console.log(comparisonSummary);
				console.log("About to call downloadCSV");
				if ( debugging ) {
					$('#legacyjsonheader').html('<h1>Comparison matrix</h1>');

					$('#legacyreceivedjson').html();
					$('#legacyreceivedjson').html(JSON.stringify(comparisonSummary));
				}
		}
		// Write out summary spreadsheet
	  downloadCSV({ data: comparisonSummary, filename: "ComparisonSummary.csv" });

	});


})  // end of document.ready

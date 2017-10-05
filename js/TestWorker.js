//
//	TestWorker.js
//
//	Normally called from TestWorker.asp
//
//  Global variables
//         baseLegacyURL:  from submitting form - will determine which legacy query to run.
//				 baseCoreURL:	 	 from submitting form to determine which Fusion environment
//                         to go to for the employee information. Initially DEV URL's for now.
//         legacyqueryid:  for selecting which query to run. Dependent on legacysource.
//				 curperson: 		 current person (ID) that we are dealing with
//				 debugging:			 Boolean - true = write debug statements to console.log
//

var defaultlegacyqueryid = "?id=49";
var baseCoreURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";
var baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp";
var curperson = 5500165;
var debugging = true;
var comparisonSummary = new Object();

// ============================================================================
function debugwrite(text) {
	if ( debugging ) {
		console.log(text);
	}
}

// ============================================================================
function paramSetup() {

	var whichlegacy;
	var whichfusion;
	var debugchoice;

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
function generateEmployeeComparisonTable() {

  	var myperson = curperson || '5500165';
	  var fusionurl = baseCoreURL + "emps?onlyData&limit=10000&q=PersonNumber=";
	  var legacyurl = baseLegacyURL + "?id=49&p1=";
  	var nullobjectstring = "{}";
  	var nullobject = {};
		var thefusionemployee = {};
		var thelegacyemployee = {};

		debugwrite("Calling paramSetup");
		paramSetup();
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

				// Must apply developed transforms before doing Y/N comparison

				var dummy = fusionTitleCode(thelegacyemployee.TITLE);
				comparison.Title = thefusionemployee.Salutation == dummy ? "OK" : "Titles differ";
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

				dummy = fusionEthnicityCode(thelegacyemployee.ETHNICITY);
				comparison.Ethnicity = thefusionemployee.Ethnicity == dummy ? "OK" : "Ethnicities differ";
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
	  var fusionurl = baseCoreURL + "emps?onlyData&limit=10000&q=PersonNumber=";
	  var legacyurl = baseLegacyURL + "?id=49&p1=";
  	var nullobjectstring = "{}";
  	var nullobject = {};
		var summarylength = 0;
		var fusion = {};
		var legacy = {};

		// Now reinitialise comparator object
		var comparison = {};

		legacyurl += myperson;
  		fusionurl += myperson;

		// Look through legacy and fusion data filling in differences
		// in comparator object
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

					comparison.PersonID = legacy.PERSONNUMBER;

					// Must apply developed transforms before doing Y/N comparison

					var dummy = fusionTitleCode(thelegacyemployee.TITLE);
					comparison.Title = thefusionemployee.Salutation == dummy ? "Y" : "N";
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
					dummy = fusionEthnicityCode(thelegacyemployee.ETHNICITY);
					comparison.Ethnicity = thefusionemployee.Ethnicity == dummy ? "Y" : "N";
					comparison.Gender = fusion.Gender == legacy.GENDER ? "Y" : "N";
					comparison.NINumber = fusion.NationalId == legacy.NATIONALID ? "Y" : "N";
					comparison.UserName = fusion.UserName == legacy.USERNAME ? "Y" : "N";

					// console.log("Inner ajax loop end for " + personcode + "- comparison object");
					// console.log( comparison );

				},
				error: function(xhr, textStatus, errorThrown) {
					$('#error').html(xhr.responseText);
					return (null);
				}

			});  // end of ajax call

			// console.log("Outside ajax but inside getJSON loops in compareEmployee for " + personcode + "- comparison object");
			// console.log( comparison );

			// This does not return correctly to calling function even though it is
			// correctly filled up here!!!!
	  });

		// console.log("Outside all AJAX loops in compareEmployee for " + personcode + "- comparison object");
		// console.log( comparison );

		return (  comparison );

}


// ============================================================================
function getLegacyEmployee(legacyemployee) {

	var thelegacyemployee = fusionemployee || 5500165;
	var result = new Object();

	// Now, construct the remainder of the URL


	// Issue the getJSON call and process return



	// return the legacy employee data to caller

	return ( result );

}

// ============================================================================
function getFusionEmployee(fusionemployee) {

	var thefusionemployee = fusionemployee || 5500165;
	var result = new Object();

	// Now, construct the remainder of the Fusion URL


	// Issue the jQuery ajax call and process return



	// return the fusion employee data to caller

	return ( result );

}


// ============================================================================
function generateComparisonSpreadsheet() {
	console.log("generateComparisonSpreadsheet called");

	// Outer getJSON call for legacy store
	var legacyurl = baseLegacyURL + "?id=48";
	var legacylist = new Array();
	var theperson;													// Tne current person we are dealing with
	var index = 0;
	var comparisonSummary = new Array();    // Holds all results of comparisons for all people

	// console.log(legacyurl);
	// console.log(typeof legacylist);

	/*
	$.ajax({
		url: legacyurl,
		dataType: 'json',
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
			return (null);
		},
		success: function(data) {
			$.each(data, function(item) {
				theperson = this.PersonCode;
				console.log(theperson+" - "+typeof theperson);
				legacylist[index] = new Number(theperson).valueOf();
				index++;
			});
		}
	});

	// End 1st JSON loop
	console.log("End of legacy JSON loop - legacylist = ");
	console.log(typeof legacylist);
	*/

	// Set up fixed array of person id's to prove concept of the
	// further logic below.

	legacylist = [5500018, 5500215, 5500165, 6704306];
	var summarylength = legacylist.length;

	// Set up loop to iterate over returned legacy list
	for (var i=0; i<summarylength; i++) {

		// Get person code

		theperson = legacylist[i];
		// console.log(theperson);

		// Call compareEmployee for this person

		var mycomparison = compareEmployee(theperson);
		comparisonSummary.push(mycomparison);
		// console.log(mycomparison);

		// Add comparisons object from the compareEmployee return to
		// the summary array (comparisonSummary)

		// summarylength = comparisonSummary.push(mycomparison);

	};

	// Send summary array to file (.csv)

	// console.log("comparisonSummary");
	// console.log(comparisonSummary);

	downloadCSV({ data: comparisonSummary, filename: "ComparisonSummary.csv" });

}

// ============================================================================
function getLegacy(legacyemployee) {

		var thelegacyemployee = legacyemployee || 5500165;
		var result = new Object();




		return ( result );
}

// ============================================================================
function getFusion(fusionemployee) {

		var thefusionemployee = fusionemployee || 5500165;
		var result = new Object();




		return ( result );
}

// ============================================================================
function runTestSuite() {

	var mylegacy = new Object();
	var myfusion = new Object();

	paramSetup();   // Set up parameters for run from submitting form.

	if (curperson) {
		mylegacy = getLegacy(curperson);

		console.log(mylegacy);

		myfusion = getFusion(curperson);

		console.log(myfusion);

	}

}

$(document).ready(function() {

	// ===========================================
	// Single Employee Comparison

	$('#personcomparator').click( function(event) {
		event.preventDefault();

		paramSetup();

    	generateEmployeeComparisonTable();

	});

	// ===========================================
	// Comparison Spreadsheet

	$('#comparisonspreadsheet').click( function(event) {
		event.preventDefault();

	  paramSetup();														// Pull in run parameters from submission form

		generateComparisonSpreadsheet(); 

	});     // end of click event for #comparisonspreadsheet

	// ===========================================
	// Comparison Spreadsheet

	$('#functiontest').click( function(event) {
		event.preventDefault();

		runTestSuite();

	});     // end of click event for #comparisonspreadsheet

})  // end of document.ready

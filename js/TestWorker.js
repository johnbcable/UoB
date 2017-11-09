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
// N.B. baseCoreURL may chnage aftre each major Oracle upgrade
var baseCoreURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";
// N.B.  baseLegacyURL will chnage depending on whic legacy system is selected (paramSetup)
var baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp";
var baselegacyqueryid = "49";
var curperson = 5500165;
var debugging = true;
var comparisonSummary = new Object();
var fusionuser = "TECHADMIN6";
var fusionpassword = "Banzai29";

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
	debugwrite(baselegacyqueryid);

	curperson = curperson || 5500165;

	// Construct appropriate starting Fusion url
	// N.B.  This URL usually changes with each major release of Fusion HCm Cloud
	baseCoreURL = "https://"+whichfusion+".hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";

	// Construct appropriate starting legacy URL
	// Done this way to preserve consistent use of query ID's across the legacy queries
	if ( whichlegacy == "ACCESS") {
		baselegacyqueryid = "";
		baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp";
	}
	if ( whichlegacy == "ALTAHRN") {
		baselegacyqueryid = "49";
		baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchALTA.asp?id=";
	}
	if ( whichlegacy == "WORKLINK") {
		baselegacyqueryid = "21";
		baseLegacyURL = "http://its-n-jcnc-01/UoB/fetchALTA.asp?id=";
	}

	// Adjust URLs to reflect submitted person code (in curperson)

	debugwrite("Values from CheckWorker form AFTER any checks or defaults applied:");
	debugwrite(curperson);
	debugwrite(whichlegacy);
	debugwrite(whichfusion);
	debugwrite(debugchoice);
	debugwrite(baselegacyqueryid);

}


// ============================================================================
// Needs refactoring to use getLegacyEmployee and get FusionEmployee
function generateEmployeeComparisonTable() {

  	var myperson = curperson || '5500165';
	  var fusionurl = baseCoreURL + "emps?onlyData&limit=10000&q=PersonNumber=";
	  var legacyurl = baseLegacyURL + "?id=" + baselegacyqueryid + "&p1=";
		var thefusionemployee = {};
		var thelegacyemployee = {};

		debugwrite("Calling paramSetup");
		paramSetup();
		debugwrite("After paramSetup");

		legacyurl += myperson;
  	fusionurl += myperson;

		thelegacyemployee = getLegacyEmployee(myperson);
		console.log("thelegacyemployee ");
		console.table(thelegacyemployee);

		thefusionemployee = getFusionEmployee(myperson);
		console.log("thefusionemployee ");
		console.table(thefusionemployee);

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

			$('#legacyreceivedjson').html(JSON.stringify(thelegacyemployee));
			$('#fusionreceivedjson').html(JSON.stringify(thefusionemployee));
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

}

// ============================================================================
// Needs refactoring to use getLegacyEmployee and get FusionEmployee
function generateComparisonSpreadsheet() {
	console.log("generateComparisonSpreadsheet called");

	// Outer getJSON call for legacy store
	var legacyurl = baseLegacyURL + "48";
	var legacylist = new Array();
	var theperson;													// Tne current person we are dealing with
	var index = 0;
	var comparisonSummary = new Array();    // Holds all results of comparisons for all people

	// Set up fixed array of person id's to prove concept of the
	// further logic below.

	legacylist = [5500018, 5500215, 5500165, 6704306];
	var summarylength = legacylist.length;

	// Set up loop to iterate over returned legacy list
	for (var i=0; i<summarylength; i++) {

		// Get person code

		theperson = legacylist[i];

		console.log("Comparing " + theperson + " ...");

		mylegacy = getLegacyEmployee(theperson);
		console.log("mylegacy ");
		console.table(mylegacy);

		myfusion = getFusionEmployee(theperson);
		console.log("myfusion ");
		console.table(myfusion);

	  if ( mylegacy && myfusion) {
			console.log("Adding " + theperson + " to comparisonSummary");
			mycomparison = comparePeople(mylegacy, myfusion);
			comparisonSummary.push(mycomparison);
		}

	};

	downloadCSV({ data: comparisonSummary, filename: "ComparisonSummary.csv" });

}

// ============================================================================
function getLegacyEmployee(legacyemployee) {

		var result = new Object();

		/*
		result = {"TITLE":"MRS.","FORENAME":"Keira","SURNAME":"Grobstein","PREFERREDNAME":null,"PERSONNUMBER":5500165,"HOMEPHONENUMBER":null,"WORKEMAIL":"e.grobstein@yopmail.com","ADDRESSLINE1":"55 Tagwell Road","ADDRESSLINE3":null,"ADDRESSLINE4":null,"CITY":"Droitwich","REGION":"Worcestershire","COUNTRY":null,"POSTALCODE":"WR9 7AQ","DATEOFBIRTH":"1971-04-26","ETHNICITY":"White-British","GENDER":"F","NATIONALID":"NX707818A","USERNAME":"QUEENNM"}
		*/

		var myperson = legacyemployee || 5500165;
	  var legacyurl = baseLegacyURL + baselegacyqueryid + "&p1=";

		var jsonstring;			// Used for legacy employee data

		legacyurl += myperson;

		$.getJSON(legacyurl, function (data) {

			// console.log("Legacy url: "+url);

			jsonstring = JSON.stringify(data[0]);

			// jsonstring = new String('{"legacydata:"' + jsonstring + '}').toString();
	    // debugwrite("Legacy jsonstring: "+jsonstring);

			result = JSON.parse(jsonstring);

		});

		return ( result );
}

// ============================================================================
function getFusionEmployee(fusionemployee) {

		var thefusionemployee = fusionemployee || 5500165;
		var result = new Object();

		/*
		result = {"Title":"MRS.","FirstName":"Keira","LastName":"Grobstein","PreferredName":null,"PersonNumber":5500165,"HomePhoneNumber":null,"WorkEmail":"e.grobstein@yopmail.com","AddressLine1":"55 Tagwell Road","AddressLine2":null,"AddressLine3":null,"City":"Droitwich","Region":"Worcestershire","Country":null,"PostalCode":"WR9 7AQ","DateOfBirth":"1971-04-26","Ethnicity":"White-British","Gender":"F","NationalId":"NX707818A","UserName":"QUEENNM"};
		*/
	  var fusionurl = baseCoreURL + "emps?onlyData&limit=10000&q=PersonNumber=" + thefusionemployee;
		var jsonstring2;		// Used for Fusion employee data


		// Now issue AJAX call to get fusion employee details
		$.ajax({
			type: "GET",
			url: fusionurl,
			dataType: "json",
			headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
			success: function(data) {
				jsonstring2 = JSON.stringify(data.items[0]);

				// debugwrite("Fusion jsonstring2: "+jsonstring2);

				result = JSON.parse(jsonstring2);

			},
			error: function(xhr, textStatus, errorThrown) {
				$('#error').html(xhr.responseText);
				return (null);
			}

		});  // end of ajax call

			return ( result );
}

// ============================================================================
function comparePeople(legacy, fusion) {

	// Now set up comparator object
	var comparison = {};

	comparison.PersonID = legacy.PERSONNUMBER;

	// Must apply developed transforms before doing Y/N comparison

	var dummy = fusionTitleCode({oldtitlecode: legacy.TITLE});
	comparison.Title = fusion.Salutation == dummy ? "Y" : "N";
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
	dummy = fusionEthnicityCode({oldethnicdescription: legacy.ETHNICITY});
	comparison.Ethnicity = fusion.Ethnicity == dummy ? "Y" : "N";
	comparison.Gender = fusion.Gender == legacy.GENDER ? "Y" : "N";
	comparison.NINumber = fusion.NationalId == legacy.NATIONALID ? "Y" : "N";
	comparison.UserName = fusion.UserName == legacy.USERNAME ? "Y" : "N";

	return (  comparison );

}

// ============================================================================
function runTestSuite() {

	var mylegacy = new Object();
	var myfusion = new Object();
	var mycomparison = new Object();
	var comparisonSummary = new Array();
	var theperson;

	paramSetup();   // Set up parameters for run from submitting form.

	// For testingh purposes, set up short list of person IDs
	var legacylist = [5500018, 5500215, 5500165, 6704306];

	var summarylength = legacylist.length;

	// Set up loop to iterate over returned legacy list
	for (var i=0; i<summarylength; i++) {

		theperson = legacylist[i];

		console.log("Comparing " + theperson + " ...");

		mylegacy = getLegacyEmployee(theperson);
		console.log("mylegacy ");
		console.table(mylegacy);

		myfusion = getFusionEmployee(theperson);
		console.log("myfusion ");
		console.table(myfusion);

	  if ( mylegacy && myfusion) {
			console.log("Adding " + theperson + " to comparisonSummary");
			mycomparison = comparePeople(mylegacy, myfusion);
			comparisonSummary.push(mycomparison);
		}

		myfusion= {};
		mylegacy = {};

		console.table(comparisonSummary);

	}   // end of for loop

}    // end of function definition

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
	// Test suite

	$('#functiontest').click( function(event) {
		event.preventDefault();

		runTestSuite();

	});     // end of click event for #functiontest

})  // end of document.ready

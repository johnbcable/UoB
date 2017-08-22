//
//	PersonComparators.js
//
//	All Javascript routines to generate provide comparison data between legacy
//  data stores and Fusion
//
//	Normally called from CheckWorker.html
//
//
var curperson = "";
var baselegacyurl = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=49";
var basefusionurl = " https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";
var myfusion = {};   // Global result from Fusion
var mylegacy = {};   // Global result from legacy data store
// Now set up local debugging flag
var debugthis = true;    	// Set to false for normal production use

// Utility functions

// Register Handlebars helpers

/*
Handlebars.registerHelper('equalsTo', function(v1, v2, options) {
    if(v1 == v2) { return options.fn(this); }
    else { return options.inverse(this); }
});
*/

//==================================================
function paramSetup() {

	curperson = $('#personcode').val();     // get the person code from form
	curperson = curperson || 5500165;

	// Blank out content of destination div's
  	$('#jsonheader').html('');
	$('#receivedjson').html('');


}

//==================================================
function getLegacyWorkerData() {

	var url = baselegacyurl + "&p1=";
	var myperson = curperson;

	url +=  myperson;

	//  console.log(url);

	// var eventsfound = false;
	$.getJSON(url, function (data) {

		// console.log("Legacy url: "+url);

		var jsonstring = JSON.stringify(data);

		jsonstring = new String("{legacydata:" + jsonstring + "}").toString();
    // console.log("Legacy jsonstring: "+jsonstring);

		var legacydata = eval("(" + jsonstring + ")");

    	$('#jsonheader').html('<h1>All Jobs</h1>');

    	$('#receivedjson').html(jsonstring);

		// Set the boolean if we have data
		// if (eventdata.length > 1)
		//	eventsfound = true;

		// $("#receivedjson").append(jsonstring);

		// downloadDAT({ data: data, filename: "AnonymousWorker.dat" });

		// Now fill in return object with Fusion comparator data

		// querylist(49) = "SELECT Title, Forename, Surname, PreferredName, PersonCode, HomeTelephone, AnonymisedWorkEmail, AddressLine1, AddressLine2, AddressLine3, Town, Region, Country, Postcode, Format(DOB,'YYYY-MM-DD') as DateOfBirth, EthnicOriginDescription, Gender, NINumber, UserName from AnonPersonFeed WHERE PersonCode = {{p1}}"

		// console.log(legacydata);
	  // console.log(legacydata.legacydata[0].Title);

		mylegacy = legacydata;
    // mylegacy = JSON.parse(JSON.stringify(legacydata.legacydata[0]));

		// console.log("Global mylegacy data structure now contains:");
		// console.log(mylegacy);

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

		//Get the HTML from the template   in the script tag
	  // var theTemplateScript = $("#fixturelist-template").html();

	  //Compile the template
	  // var theTemplate = Handlebars.compile (theTemplateScript);
		// Handlebars.registerPartial("description", $("#shoe-description").html());
		// Clear out detsination HTML element
		// $("#main").empty();
		// Append template filled with data
		// $("#main").append (theTemplate(fixturedata));

	});  // end of function(data)

	// console.log("My title in global data object inside getLegacyWorkerData is "+mylegacy['Title']);

  // return true;
}

// ============================================================================
function getFusionWorkerData() {

	var url = basefusionurl + "emps?onlyData&limit=10&q=PersonNumber=";
	var myperson = curperson;

	url += myperson;
	console.log(url);

	$('#jsonheader').html('');
	$('#receivedjson').html('');

  	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {

      	var jsonstring = JSON.stringify(data);
		      // console.log("Fusion data: "+data);

		    $('#jsonheader').html('<h1>Fusion Worker Data</h1>');

				$('#receivedjson').html(jsonstring);

		      // $("#comparisonresults").empty();
		  		// Append template filled with data
		  		// $("#comparisonresults").append (jsonstring);

		  		// jsonstring = new String("{fusionperson:"+jsonstring+"}");
		      // console.log("Fusion jsonstring: "+jsonstring);

		  	// var fusiondata = eval("(" + jsonstring + ")");

		      // console.log(fusiondata);
		  	  // console.log(fusiondata.fusiondata[0].Title);

		     // myfusion = JSON.parse(JSON.stringify(fusiondata));

		  		// console.log("Global myfusion data structure now contains:");
		  		// console.log(myfusion);

		  		// Now fill in return object with Fusion comparator data
		  		/*
		      myfusion.Title=data.items[0].Salutation;
		  		myfusion.Forename=data.items[0].FirstName;
		  		myfusion.Surname=data.items[0].LastName;
		  		myfusion.PreferredName=data.items[0].PreferredName;
		  		myfusion.PersonCode=data.items[0].PersonNumer;
		  		myfusion.HomeTelephone=data.items[0].HomePhoneNumber;
		  		myfusion.WorksEmailAddress=data.items[0].WorkEmail;
		  		myfusion.AddressLine1=data.items[0].AddressLine1;
		  		myfusion.AddressLine2=data.items[0].AddressLine2;
		  		myfusion.AddressLine3=data.items[0].AddressLine3;
		  		myfusion.Town=data.items[0].City;
		  		myfusion.Region=data.items[0].Region;
		  		myfusion.Country=data.items[0].Country;
		  		myfusion.Postcode=data.items[0].PostalCode;
		  		myfusion.DateOfBirth=data.items[0].DateOfBirth;
		  		myfusion.EthnicOriginDescription=data.items[0].Ethnicity;
		  		myfusion.Gender=data.items[0].Gender;
		  		myfusion.NINumber=data.items[0].NationalId;
		  		myfusion.UserName=data.items[0].UserName;
		      */

		      //Get the HTML from the template   in the script tag
		  	  // var theTemplateScript = $("#fusionlist-template").html();

		  	  //Compile the template
		  	  // var theTemplate = Handlebars.compile (theTemplateScript);
		  		// Handlebars.registerPartial("description", $("#shoe-description").html());
		  		// Clear out detsination HTML element
		  		// $("#comparisonresults").empty();
		  		// Append template filled with data
		  		// $("#comparisonresults").append (theTemplate(fusiondata));

		  		// return(fusiondata);
				},
				error: function(xhr, textStatus, errorThrown) {
					$('#error').html(xhr.responseText);
				}

	});  // end of ajax call

	// console.log(myfusion);
  // return true;

}


$(document).ready(function() {

  var result;

  /*
	$('#personcomparator').click( function(event) {
		event.preventDefault();
		*/
		/*
		if (debugthis) {
			console.log('Before paramSetup ........................');
			console.log('fixturesurl is '+fixturesurl);
			console.log('teamurl is '+teamurl);
			console.log('baseurl is '+baseurl);
			console.log('curseason is '+curseason);
		}
		*/

		// paramSetup();

		/*
		if (debugthis) {
			console.log('After paramSetup .........................');
			console.log('fixturesurl is '+fixturesurl);
			console.log('teamurl is '+teamurl);
			console.log('baseurl is '+baseurl);
			console.log('curseason is '+curseason);
		}
		*/

		// Get legacy data for this person

		// getLegacyWorkerData();
		// console.log("mylegacy after getLegacyWorkerData: "+mylegacy);


		// Get fusion data for this person

		// getFusionWorkerData();
    // console.log("myfusion after getFusionWorkerData: "+myfusion);

	// });


})  // end of document.ready

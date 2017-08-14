//
//	PersonComparators.js
//
//	All Javascript routines to generate provide comparison data between legacy
//  data stores and Fusion
//
//	Normally called from CheckWorker.html
//
//
var curperson = new String("").toString();
var baselegacyurl = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=49"
var basefusionurl = " https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/emps/?onlyData"
var myfusion = new Object();   // Global result from Fusion
var mylegacy = new Object();   // Global result from legacy data store

//==================================================
function paramSetup() {

	curperson = $('#personcode').val();     // get the person code from form
	curperson = curperson || 5500165;

	console.log("Current person = "+curperson);

}

//==================================================
function getLegacyWorkerData() {

	var url = baselegacyurl;
	var myperson = curperson;

	url += "&p1="+myperson;
	console.log(url);

	// var eventsfound = false;
	$.getJSON(url,function(data){

		console.log(data);

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

		// downloadDAT({ data: data, filename: "AnonymousWorker.dat" });

		// Now fill in return object with Fusion comparator data

		querylist(49) = "SELECT Title, Forename, Surname, PreferredName, PersonCode, HomeTelephone, AnonymisedWorkEmail, AddressLine1, AddressLine2, AddressLine3, Town, Region, Country, Postcode, Format(DOB,'YYYY-MM-DD') as DateOfBirth, EthnicOriginDescription, Gender, NINumber, UserName from AnonPersonFeed WHERE PersonCode = {{p1}}"

		mylegacy.Title=data.Title;
		mylegacy.Forename=data.Forename;
		mylegacy.Surname=data.items.LastName;
		mylegacy.PreferredName=data.PreferredName;
		mylegacy.PersonCode=data.PersonCode;
		mylegacy.HomeTelephone=data.HomeTelephone;
		mylegacy.WorksEmailAddress=data.AnonymisedWorkEmail;
		mylegacy.AddressLine1=data.AddressLine1;
		mylegacy.AddressLine2=data.AddressLine2;
		mylegacy.AddressLine3=data.AddressLine3;
		mylegacy.Town=data.Town;
		mylegacy.Region=data.Region;
		mylegacy.Country=data.Country;
		mylegacy.Postcode=data.Postcode;
		mylegacy.DateOfBirth=data.DateOfBirth;
		mylegacy.EthnicOriginDescription=data.EthnicOriginDescription;
		mylegacy.Gender=data.Gender;
		mylegacy.NINumber=data.NINumber;
		mylegacy.UserName=data.UserName;

		// return(legacydata);

	});  // end of function(data)

}

// ============================================================================
function getFusionWorkerData() {

	var url = basefusionurl;
	var myperson = curperson;

	url += "&q=PersonNumber="+myperson;
	console.log(url);

	// var eventsfound = false;
	$.getJSON(url,function(data){

		console.log(data.items);

		// Now fill in return object with Fusion comparator data
		myfusion.Title=data.items["Salutation"];
		myfusion.Forename=data.items.FirstName;
		myfusion.Surname=data.items.LastName;
		myfusion.PreferredName=data.items.PreferredName;
		myfusion.PersonCode=data.items.PersonNumer;
		myfusion.HomeTelephone=data.items.HomePhoneNumber;
		myfusion.WorksEmailAddress=data.items.WorkEmail;
		myfusion.AddressLine1=data.items.AddressLine1;
		myfusion.AddressLine2=data.items.AddressLine2;
		myfusion.AddressLine3=data.items.AddressLine3;
		myfusion.Town=data.items.City;
		myfusion.Region=data.items.Region;
		myfusion.Country=data.items.Country;
		myfusion.Postcode=data.items.PostalCode;
		myfusion.DateOfBirth=data.items.DateOfBirth;
		myfusion.EthnicOriginDescription=data.items.Ethnicity;
		myfusion.Gender=data.items.Gender;
		myfusion.NINumber=data.items.NationalId;
		myfusion.UserName=data.items.UserName;

		// return(fusiondata);

	});  // end of function(data)

}


$(document).ready(function() {

	$('#mysubmit').click( function(event) {
		event.preventDefault();

		/*
		if (debugthis) {
			console.log('Before paramSetup ........................');
			console.log('fixturesurl is '+fixturesurl);
			console.log('teamurl is '+teamurl);
			console.log('baseurl is '+baseurl);
			console.log('curseason is '+curseason);
		}
		*/

		paramSetup();

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

		getLegacyWorkerData()
		console.log(mylegacy);


		// Get fusion data for this person

		getFusionWorkerData()
		console.log(myfusion);


	});


})  // end of document.ready

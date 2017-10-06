/*********************************************

datatransforms.js

Contains Javascript versions of transformation
functions to be used as part of the data migration
pipeline.

fusionCountryCode(oldcountrycode, baseurl)
fusionEthnicityCode(oldethnicdescription, baseurl)
fusionReligiousBelief(oldreligiousbelief, baseurl)
fusionTitleCode(oldtitlecode, baseurl)
fusionRelationship(oldrelationship, baseurl)

**********************************************/

// Global enumerated variables

var CountryQuery = 31;
var TitleQuery = 30;

// ============================================================================
function fusionCountryCode(args) {

	var mycountry, myurl, mappingurl;

	var result = new String("GB").toString();   // Default to Great Britain

	// Process supplied args
	oldcountrycode, baseurl
	mycountry = args.oldcountrycode || "NULL";
	mycountry = mycountry.toUpperCase();

	myurl = args.baseurl || "ACCESS";
	myurl = myurl == "ACCESS" ? "http://its-n-jcnc-01/fetchJSON.asp" : "http://its-n-jcnc-01/fetchALTA.asp";

	mappingurl = myurl+"?id="+CountryQuery+"&p1="+mycountry;

	console.log(mappingurl);

	// Now do the getJSON call using the mappingurl
	$.getJSON(mappingurl, function (data) {
		// console.log("Legacy url: "+url);

		jsonstring = JSON.stringify(data[0]);

		// jsonstring = new String('{"legacydata:"' + jsonstring + '}').toString();
    // debugwrite("Legacy jsonstring: "+jsonstring);
	});

	switch(mycountry) {

	   case "UNITED STATES":
	      result = "US";
	      break;
	   case "MALTA":
	      result = "MT";
	      break;
	   case "LUXEMBOURG":
	      result = "LU";
	      break;
	   case "IRELAND":
	      result = "IE";
	      break;
	   case "CYPRUS":
	      result = "XB";
	      break;
	   case "INDIA":
	      result = "IN";
	      break;
	   case "ITALY":
	      result = "IT";
	      break;
	   case "NULL":
	      result = "GB";
	      break;
	   default:
	      result = "GB";
	}


	return (result);

}

// ============================================================================
function fusionEthnicityCode(args) {

	var myethnic = new String("");
	var result = new String("10");     // default to White-British
	var myurl;

	// Process supplied args
	oldcountrycode, baseurl
	myethnic = args.oldethnicdescription || "NULL";

	myurl = args.baseurl || "ACCESS";
	myurl = myurl == "ACCESS" ? "http://its-n-jcnc-01/fetchJSON.asp" : "http://its-n-jcnc-01/fetchALTA.asp";

	switch(myethnic) {

	    case "Arab":
	        result = new String("50");
	        break;
	    case "Asian or Asian British-Bangladeshi":
	        result = new String("33");
	        break;
	    case "Asian or Asian British-Indian":
	        result = new String("31");
	        break;
	    case "Asian or Asian British-Pakistani":
	        result = new String("32");
	        break;
	    case "Black or Black British-African":
	        result = new String("22");
	        break;
	    case "Black or Black British-Caribbean":
	        result = new String("21");
	        break;
	    case "Chinese":
	        result = new String("34");
	        break;
	    case "Mixed-White And Asian":
	        result = new String("43");
	        break;
	    case "Mixed-White and Black African":
	        result = new String("42");
	        break;
	    case "Mixed-White and Black Caribbean":
	        result = new String("21");
	        break;
	    case "Other Asian background":
	        result = new String("39");
	        break;
	    case "Other Black Background":
	        result = new String("29");
	        break;
	    case "Other Ethnic background":
	        result = new String("80");
	        break;
	    case "Other Mixed background":
	        result = new String("49");
	        break;
	    case "Other White Background":
	        result = new String("10");
	        break
	    case "Prefer not to disclose":
	        result = new String("98");
	        break;
	    case "White-British":
	        result = new String("10");
	        break;
	    case "White-Irish":
	        result = new String("10");
	        break;
	   case "NULL":
	      result = new String("90");
	      break;
	   default:
	      result = new String("90");

	}

	return ( result );

}


// ============================================================================
function fusionReligiousBelief(args) {

	var result;
	var myurl;

	// Process supplied args
	var myReligion = args.oldreligiousbelief || "98";

	myurl = args.baseurl || "ACCESS";
	myurl = myurl == "ACCESS" ? "http://its-n-jcnc-01/fetchJSON.asp" : "http://its-n-jcnc-01/fetchALTA.asp";

	// myReligion = Array("01", "02", "03", "10", "11", "12", "13", "14", "80", "98")

	result = myReligion;
}


// ============================================================================
function fusionTitleCode(args) {

	var myurl;

	// Process supplied args
	var mytitle = args.oldtitlecode || "NULL";

	myurl = args.baseurl || "ACCESS";
	myurl = myurl == "ACCESS" ? "http://its-n-jcnc-01/fetchJSON.asp" : "http://its-n-jcnc-01/fetchALTA.asp";

	mytitle = mytitle.toUpperCase();

	// If mytitle is not NULL, try and get its bona-fide Fusion
	// equivalent from TITLECODES table

	return ( mytitle );

}


// ============================================================================
function fusionRelationship(args) {

	var myurl;

	// Process supplied args
	var myrelationship = args.oldrelationship || "NULL";

	myurl = args.baseurl || "ACCESS";
	myurl = myurl == "ACCESS" ? "http://its-n-jcnc-01/fetchJSON.asp" : "http://its-n-jcnc-01/fetchALTA.asp";

	myrelationship = myrelationship.toUpperCase();

	return( myrelationship );

}

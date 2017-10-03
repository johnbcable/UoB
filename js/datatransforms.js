/*********************************************

datatransforms.js

Contains Javascript versions of transformation 
functions to be used as part of the data migration 
pipeline.

fusionCountryCode(oldcountrycode)
fusionEthnicityCode(oldethnicdescription)
fusionReligiousBelief(oldreligiousbelief)
fusionTitleCode(oldtitlecode)
fusionRelationship(oldrelationship)

**********************************************/
function fusionCountryCode(oldcountrycode)

var mycountry;

	var result = new String("GB").toString();

	mycountry = oldcountrycode || "NULL";
	mycountry = mycountry.toUpperCase();

	switch(mycountry) {

	   case: "UNITED STATES"
	      result = "US";
	   case: "MALTA"
	      result = "MT";
	   case: "LUXEMBOURG"
	      result = "LU";
	   case: "IRELAND"
	      result = "IE";
	   case: "CYPRUS"
	      result = "XB";
	   case: "INDIA"
	      result = "IN";
	   case: "ITALY"
	      result = "IT";
	   case: "NULL"
	      result = "GB";
	   default:
	      result = "GB";
	}


	return (result);

}

function fusionEthnicityCode(oldethnicdescription) {

	var myethnic = new String("");
	var result = new String("10");     // default to White-British
	myethnic = oldethnicdescription || "NULL";

	switch(myethnic) {

	    case: "Arab"
	        result = new String("50");
	        break;
	    case: "Asian or Asian British-Bangladeshi"
	        result = new String("33");
	        break;
	    case: "Asian or Asian British-Indian"
	        result = new String("31");
	        break;
	    case: "Asian or Asian British-Pakistani"
	        result = new String("32");
	        break;
	    case: "Black or Black British-African"
	        result = new String("22");
	        break;
	    case: "Black or Black British-Caribbean"
	        result = new String("21");
	        break;
	    case: "Chinese"
	        result = new String("34");
	        break;
	    case: "Mixed-White And Asian"
	        result = new String("43");
	        break;
	    case: "Mixed-White and Black African"
	        result = new String("42");
	        break;
	    case: "Mixed-White and Black Caribbean"
	        result = new String("21");
	        break;
	    case: "Other Asian background"
	        result = new String("39");
	        break;
	    case: "Other Black Background"
	        result = new String("29");
	        break;
	    case: "Other Ethnic background"
	        result = new String("80");
	        break;
	    case: "Other Mixed background"
	        result = new String("49");
	        break;
	    case: "Other White Background"
	        result = new String("10");
	        break
	    case: "Prefer not to disclose"
	        result = new String("98");
	        break;
	    case: "White-British"
	        result = new String("10");
	        break;
	    case: "White-Irish"
	        result = new String("10");
	        break;
	   case: "NULL"
	      result = new String("90");
	      break;
	   default: 
	      result = new String("90");

	}

	return ( result );

}


function fusionReligiousBelief(oldreligiousbelief) {

	var myReligion = oldreligiousbelief || "98";

	var result;

	// myReligion = Array("01", "02", "03", "10", "11", "12", "13", "14", "80", "98")

	result = myReligion;
}


function fusionTitleCode(oldtitlecode) {

	var mytitle = oldtitlecode || "NULL";

	mytitle = mytitle.toUpperCase();

	return ( mytitle );

}


function fusionRelationship(oldrelationship) {

	var myRelationship = oldrelationship || "NULL";

	myrelationship = myrelationship.toUpperCase();

	return( myrelationship );

}


<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Cache-Control", "no-cache,no-store,must-revalidate");
Response.AddHeader("Pragma", "no-cache");
Response.AddHeader("Expires", 0);
Response.AddHeader("Access-Control-Allow-Origin", "*");
%>
<!--#include file="functions.asp" -->
<!--#include file="strings.asp" -->
<!--#include file="emailfuncs.asp" -->
<!--#include file="memberfuncs.asp" -->
<%


var strtime, strdate, title2;
var clubname = new String("Hampton-In-Arden Sports Club");
var pagetitle = new String("Updating Preference Details");
// Now for any functions and variables local to this page

// Now for any variables local to this page
var dbconnect=Application("hamptonsportsdb"); 
var RS, Conn, SQL1, SQL2;
var debugging=current_debug_status();
var memberObj = new Object();
var resultObj = new Object();

var uniqueref;
var mSingles, mDoubles, mMixed, mMixedPlate, mChallengerMixed;
var mDoublesPartner, mMixedPartner, mChallengerMixedPartner;
var mVets45plusPartner, mVets50PlusPartner, mVets60PlusPartner;
var mVets45, mVets50, mVets60;
var teamhelp, socialhelp, adminhelp, arden9help;
var teamHelpText, socialHelpText, adminHelpText;
var mWeekday, mWeekend, mPhotoConsent;
var mSummerFinalsDay, mAutumnFinalsDay, mJuniorFinalsDay;
var singlesBoxLeague, doublesBoxLeague;
var vets45plus, vets50Plus, vets60Plus;
var vets45plusPartner, vets50PlusPartner, vets60PlusPartner;
var detailscorrect = new String("Y").toString();
var mydebug = false;  // Default for production use.
var sendboxleagueemail = false;


// Set up default greeting strings
strdate = datestring();
strtime = timestring();
//
debugging = false;    // Production = false

// defaults for variables

mSingles = new String("N").toString();
mDoubles = new String("N").toString();
mMixed = new String("N").toString();
mChallengerMixed = new String("N").toString();
mMixedPlate = new String("N").toString();
mDoublesPartner = new String("Not specified").toString();
mMixedPartner = new String("Not specified").toString();
mChallengerMixedPartner = new String("Not specified").toString();
mVets45 = new String("N").toString();
mVets50 = new String("N").toString();
mVets60 = new String("N").toString();
mVets45plusPartner = new String("Not specified").toString();
mVets50PlusPartner = new String("Not specified").toString();
mVets60PlusPartner = new String("Not specified").toString();
teamhelp = new String("N").toString();
socialhelp = new String("N").toString();
adminhelp = new String("N").toString();
arden9help = new String("N").toString();
mWeekday = new String("N").toString();
mWeekend = new String("N").toString();
mPhotoConsent = new String("Y").toString();
mSummerFinalsDay = new String("Y").toString();
mAutumnFinalsDay = new String("Y").toString();
mJuniorFinalsDay = new String("Y").toString();
singlesBoxLeague = new String("N").toString();
doublesBoxLeague = new String("N").toString();
teamHelpText = new String("").toString();
socialHelpText = new String("N").toString();
adminHelpText = new String("N").toString();

// Retrieve POST'ed data

uniqueref = Request.Form("uniqueref");

mydebug = Request.QueryString("debug");
if (mydebug == "" || mydebug == "null" || mydebug == "undefined")
{
	mydebug = new String("N").toString();
}
if (mydebug == "Y") {
	debugging = true;
} else {
	debugging = false;
}

// debugging = true;    

// Retrieve existing member data
memberObj = getMember(uniqueref);
if (debugging) {
	printMember(memberObj);
}

mSingles = Trim(new String(Request.Form("singles")));
if (mSingles == "" || mSingles =="null" || mSingles == "undefined")
{
	mSingles = new String("N").toString();
} else {
	mSingles = new String("Y").toString();
}

mDoubles = Trim(new String(Request.Form("doubles")));
if (mDoubles == "" || mDoubles =="null" || mDoubles == "undefined")
{
	mDoubles = new String("N").toString();
} else {
	mDoubles = new String("Y").toString();
}

mDoublesPartner = Trim(new String(Request.Form("doublespartner")));
if (mDoublesPartner == "" || mDoublesPartner =="null" || mDoublesPartner == "undefined")
{
	mDoublesPartner = new String("Not specified").toString();
} 

mMixed = Trim(new String(Request.Form("mixeddoubles")));
if (mMixed == "" || mMixed =="null" || mMixed == "undefined")
{
	mMixed = new String("N").toString();
} else {
	mMixed = new String("Y").toString();
}

mMixedPartner = Trim(new String(Request.Form("mixedpartner")));
if (mMixedPartner == "" || mMixedPartner =="null" || mMixedPartner == "undefined")
{
	mMixedPartner = new String("Not specified").toString();
} 

mChallengerMixed = Trim(new String(Request.Form("challengermixeddoubles")));
if (mChallengerMixed == "" || mChallengerMixed =="null" || mChallengerMixed == "undefined")
{
	mChallengerMixed = new String("N").toString();
} else {
	mChallengerMixed = new String("Y").toString();
}

mChallengerMixedPartner = Trim(new String(Request.Form("challengermixedpartner")));
if (mChallengerMixedPartner == "" || mChallengerMixedPartner =="null" || mChallengerMixedPartner == "undefined")
{
	mChallengerMixedPartner = new String("Not specified").toString();
} 

mMixedPlate = Trim(new String(Request.Form("mixedplate")));
if (mMixedPlate == "" || mMixedPlate =="null" || mMixedPlate == "undefined")
{
	mMixedPlate = new String("N").toString();
} else {
	mMixedPlate = new String("Y").toString();
}

mVets45 = Trim(new String(Request.Form("vets45plus")));
if (mVets45 == "" || mVets45 =="null" || mVets45 == "undefined")
{
	mVets45 = new String("N").toString();
} else {
	mVets45 = new String("Y").toString();
}

mVets45plusPartner = Trim(new String(Request.Form("vets45pluspartner")));
if (mVets45plusPartner == "" || mVets45plusPartner =="null" || mVets45plusPartner == "undefined")
{
	mVets45plusPartner = new String("Not specified").toString();
} 

mVets50 = Trim(new String(Request.Form("vets50plus")));
if (mVets50 == "" || mVets50 =="null" || mVets50 == "undefined")
{
	mVets50 = new String("N").toString();
} else {
	mVets50 = new String("Y").toString();
}

mVets50PlusPartner = Trim(new String(Request.Form("vets50pluspartner")));
if (mVets50PlusPartner == "" || mVets50PlusPartner =="null" || mVets50PlusPartner == "undefined")
{
	mVets50PlusPartner = new String("Not specified").toString();
} 

mVets60 = Trim(new String(Request.Form("vets60plus")));
if (mVets60 == "" || mVets60 =="null" || mVets60 == "undefined")
{
	mVets60 = new String("N").toString();
} else {
	mVets60 = new String("Y").toString();
}

mVets60PlusPartner = Trim(new String(Request.Form("vets60pluspartner")));
if (mVets60PlusPartner == "" || mVets60PlusPartner =="null" || mVets60PlusPartner == "undefined")
{
	mVets60PlusPartner = new String("Not specified").toString();
} 

teamhelp = Trim(new String(Request.Form("teamhelp")));
if (teamhelp == "" || teamhelp =="null" || teamhelp == "undefined")
{
	teamhelp = new String("N").toString();
} else {
	teamhelp = new String("Y").toString();
}

teamHelpText = Trim(new String(Request.Form("teamhelptext")));
if (teamHelpText == "" || teamHelpText =="null" || teamHelpText == "undefined")
{
	teamHelpText = new String("").toString();
} 

socialhelp = Trim(new String(Request.Form("socialhelp")));
if (socialhelp == "" || socialhelp =="null" || socialhelp == "undefined")
{
	socialhelp = new String("N").toString();
} else {
	socialhelp = new String("Y").toString();
}

socialHelpText = Trim(new String(Request.Form("socialhelptext")));
if (socialHelpText == "" || socialHelpText =="null" || socialHelpText == "undefined")
{
	socialHelpText = new String("").toString();
} 

adminhelp = Trim(new String(Request.Form("adminhelp")));
if (adminhelp == "" || adminhelp =="null" || adminhelp == "undefined")
{
	adminhelp = new String("N").toString();
} else {
	adminhelp = new String("Y").toString();
}

adminHelpText = Trim(new String(Request.Form("adminhelptext")));
if (adminHelpText == "" || adminHelpText =="null" || adminHelpText == "undefined")
{
	adminHelpText = new String("").toString();
} 

arden9help = Trim(new String(Request.Form("arden9help")));
if (arden9help == "" || arden9help =="null" || arden9help == "undefined")
{
	arden9help = new String("N").toString();
} else {
	arden9help = new String("Y").toString();
}

mWeekday = Trim(new String(Request.Form("wimbledonweekday")));
if (mWeekday == "" || mWeekday =="null" || mWeekday == "undefined")
{
	mWeekday = new String("N").toString();
} else {
	mWeekday = new String("Y").toString();
}

mWeekend = Trim(new String(Request.Form("wimbledonweekend")));
if (mWeekend == "" || mWeekend =="null" || mWeekend == "undefined")
{
	mWeekend = new String("N").toString();
} else {
	mWeekend = new String("Y").toString();
}

mPhotoConsent = Trim(new String(Request.Form("photoconsent")));
if (mPhotoConsent == "" || mPhotoConsent =="null" || mPhotoConsent == "undefined")
{
	mPhotoConsent = new String("N").toString();
} else {
	mPhotoConsent = new String("Y").toString();
}

mSummerFinalsDay = Trim(new String(Request.Form("summerfinalsday")));
if (mSummerFinalsDay == "" || mSummerFinalsDay =="null" || mSummerFinalsDay == "undefined")
{
	mSummerFinalsDay = new String("N").toString();
} else {
	mSummerFinalsDay = new String("Y").toString();
}

mAutumnFinalsDay = Trim(new String(Request.Form("autumnfinalsday")));
if (mAutumnFinalsDay == "" || mAutumnFinalsDay =="null" || mAutumnFinalsDay == "undefined")
{
	mAutumnFinalsDay = new String("N").toString();
} else {
	mAutumnFinalsDay = new String("Y").toString();
}

mJuniorFinalsDay = Trim(new String(Request.Form("juniorfinalsday")));
if (mJuniorFinalsDay == "" || mJuniorFinalsDay =="null" || mJuniorFinalsDay == "undefined")
{
	mJuniorFinalsDay = new String("N").toString();
} else {
	mJuniorFinalsDay = new String("Y").toString();
}

singlesBoxLeague = Trim(new String(Request.Form("singlesBoxLeague")));
if (singlesBoxLeague == "" || singlesBoxLeague =="null" || singlesBoxLeague == "undefined")
{
	singlesBoxLeague = new String("N").toString();
} else {
	singlesBoxLeague = new String("Y").toString();
}

doublesBoxLeague = Trim(new String(Request.Form("doublesBoxLeague")));
if (doublesBoxLeague == "" || doublesBoxLeague =="null" || doublesBoxLeague == "undefined")
{
	doublesBoxLeague = new String("N").toString();
} else {
	doublesBoxLeague = new String("Y").toString();
}

// Update members details from POST'ed data


Conn = Server.CreateObject("ADODB.Connection");
RS = Server.CreateObject("ADODB.RecordSet");
Conn.Open(dbconnect);
SQLstart = new String("UPDATE members ")
SQLend = new String(" WHERE uniqueref="+uniqueref).toString();
SQLmiddle = new String("SET ").toString();
SQLmiddle += " singles='"+mSingles+"',";
SQLmiddle += " doubles='"+mDoubles+"',";
SQLmiddle += " mixeddoubles='"+mMixed+"',";
SQLmiddle += " challengermixeddoubles='"+mChallengerMixed+"',";
SQLmiddle += " mixedplate='"+mMixedPlate+"',";
SQLmiddle += " vets45plus='"+mVets45+"',"
SQLmiddle += " vets50plus='"+mVets50+"',"
SQLmiddle += " vets60plus='"+mVets60+"',"
SQLmiddle += " doublespartner='"+mDoublesPartner+"',";
SQLmiddle += " mixedpartner='"+mMixedPartner+"',";
SQLmiddle += " challengermixedpartner='"+mChallengerMixedPartner+"',";
SQLmiddle += " summerfinalsday='"+mSummerFinalsDay+"',";
SQLmiddle += " autumnfinalsday='"+mAutumnFinalsDay+"',";
SQLmiddle += " juniorfinalsday='"+mJuniorFinalsDay+"',";
SQLmiddle += " teamhelp='"+teamhelp+"',";
SQLmiddle += " socialhelp='"+socialhelp+"',";
SQLmiddle += " adminhelp='"+adminhelp+"',";
SQLmiddle += " arden9help='"+arden9help+"',";
SQLmiddle += " detailscorrect='"+detailscorrect+"',";
SQLmiddle += " detailscorrectdate='"+today()+"',";
SQLmiddle += " vets45pluspartner='"+mVets45plusPartner+"',"
SQLmiddle += " vets50pluspartner='"+mVets50PlusPartner+"',"
SQLmiddle += " vets60pluspartner='"+mVets60PlusPartner+"',"
SQLmiddle += " wimbledonweekday='"+mWeekday+"', ";
SQLmiddle += " wimbledonweekend='"+mWeekend+"', ";

SQLmiddle += " singlesboxleague='"+singlesBoxLeague+"',";
SQLmiddle += " doublesboxleague='"+doublesBoxLeague+"',";

SQLmiddle +=" teamhelptext='"+teamHelpText+"',"
SQLmiddle +=" socialhelptext='"+socialHelpText+"',"
SQLmiddle +=" adminhelptext='"+adminHelpText+"',"

SQLmiddle += " photoconsent='"+mPhotoConsent+"' ";

resultObj.result = true;
resultObj.errno = 0;
resultObj.description = new String("").toString();

SQL1 = new String(SQLstart+SQLmiddle+SQLend).toString();
resultObj.sql = new String(SQL1).toString();

try {
	RS = Conn.Execute(SQL1);
}
catch(e) {
	resultObj.result = false;
	resultObj.errno = (e.number & 0xFFFF);
	resultObj.description += e.description;
	resultObj.sql = new String(SQLstart+SQLmiddle+SQLend).toString();
}

// Now, if box league preferences have been changed, send email to boxleagues organisers

sendboxleagueemail = false;

if (debugging) {
	Response.Write("Existing Singles box league preference is "+memberObj.singlesboxleague+"; new one is "+singlesBoxLeague+"<br />");
	Response.Write("Existing Doubles box league preference cis "+memberObj.doublesboxleague+"; new one is "+doublesBoxLeague+"<br />");
}

if (! (memberObj.singlesboxleague == singlesBoxLeague) ) {
	if (debugging) {
		Response.Write("Singles box league preference changed from "+memberObj.singlesboxleague+" to "+singlesBoxLeague+"<br />");
	}
	sendboxleagueemail = true;
}
if (! (memberObj.doublesboxleague == doublesBoxLeague) ) {
	if (debugging) {
		Response.Write("Singles box league preference changed from "+memberObj.doublesboxleague+" to "+doublesBoxLeague+"<br />");
	}
	sendboxleagueemail = true;
}

if (debugging) {
	Response.Write("<br />I "+(sendboxleagueemail? "will" : "won't")+" send an email to the box league administrators<br />")
}


// On completion, redirect to renewthankyou.html if not debugging

if (debugging) {
	Response.Write("Information from the DB update:<br />");
	Response.Write("Result: "+ resultObj.result ? "TRUE" : "FALSE");
	Response.Write("<br />errno: "+resultObj.errno+"<br />");
	Response.Write("Description: "+resultObj.description+"<br />");
	Response.Write("SQL used: "+resultObj.sql+"<br /><br />");
	Response.Write("Dont know where to redirect to after this yet.<br />");
	Response.Write("Landed at preferences saving page.<br />");
	Response.Write("<h3>Values POST-ed</h3>");
	Response.Write("<table>");
	Response.Write("<tr><td>Singles decoded</td><td>"+mSingles+"</td></tr>");
	Response.Write("<tr><td>Doubles decoded</td><td>"+mDoubles+"</td></tr>");
	Response.Write("<tr><td>Doubles partner</td><td>"+mDoublesPartner+"</td></tr>");
	Response.Write("<tr><td>Mixed Doubles decoded</td><td>"+mMixed+"</td></tr>");
	Response.Write("<tr><td>Mixed Doubles partner</td><td>"+mMixedPartner+"</td></tr>");
	Response.Write("<tr><td>Challenger Mixed Doubles decoded</td><td>"+mChallengerMixed+"</td></tr>");
	Response.Write("<tr><td>Challenger Mixed Doubles partner</td><td>"+mChallengerMixedPartner+"</td></tr>");
	Response.Write("<tr><td>Mixed Doubles Plate decoded</td><td>"+mMixedPlate+"</td></tr>");
	Response.Write("<tr><td>Vets &gt; 45</td><td>"+mVets45+"</td></tr>");
	Response.Write("<tr><td>Vets &gt; 45 partner</td><td>"+mVets45plusPartner+"</td></tr>");
	Response.Write("<tr><td>Vets &gt; 50</td><td>"+mVets50+"</td></tr>");
	Response.Write("<tr><td>Vets &gt; 50 partner</td><td>"+mVets50PlusPartner+"</td></tr>");
	Response.Write("<tr><td>Vets &gt; 60</td><td>"+mVets60+"</td></tr>");
	Response.Write("<tr><td>Vets &gt; 60 partner</td><td>"+mVets60PlusPartner+"</td></tr>");
	Response.Write("<tr><td>Team help decoded</td><td>"+teamhelp+"</td></tr>");
	Response.Write("<tr><td>Team help text</td><td>"+teamHelpText+"</td></tr>");
	Response.Write("<tr><td>Social help decoded</td><td>"+socialhelp+"</td></tr>");
	Response.Write("<tr><td>Social help text</td><td>"+socialHelpText+"</td></tr>");
	Response.Write("<tr><td>Admin help decoded</td><td>"+adminhelp+"</td></tr>");
	Response.Write("<tr><td>Admin help text</td><td>"+adminHelpText+"</td></tr>");
	Response.Write("<tr><td>Arden-9 help decoded</td><td>"+arden9help+"</td></tr>");
	Response.Write("<tr><td>Wimbledon weekday decoded</td><td>"+mWeekday+"</td></tr>");
	Response.Write("<tr><td>Wimbledon weekend decoded</td><td>"+mWeekend+"</td></tr>");
	Response.Write("<tr><td>Photo consent decoded</td><td>"+mPhotoConsent+"</td></tr>");
	Response.Write("<tr><td>Singles box league decoded</td><td>"+singlesBoxLeague+"</td></tr>");
	Response.Write("<tr><td>Doubles box league decoded</td><td>"+doublesBoxLeague+"</td></tr>");

	Response.Write("</table>");

	Response.End();

}
	// Normal end so redirect to thank-you page

	Response.Redirect("/renewthankyou.html")

%>


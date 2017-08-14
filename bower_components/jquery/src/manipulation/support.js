<<<<<<< HEAD
define([
	"../var/support"
], function( support ) {

(function() {
=======
define( [
	"../var/document",
	"../var/support"
], function( document, support ) {

"use strict";

( function() {
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	var fragment = document.createDocumentFragment(),
		div = fragment.appendChild( document.createElement( "div" ) ),
		input = document.createElement( "input" );

<<<<<<< HEAD
	// Support: Safari<=5.1
=======
	// Support: Android 4.0 - 4.3 only
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	// Check state lost if the name is set (#11217)
	// Support: Windows Web Apps (WWA)
	// `name` and `type` must use .setAttribute for WWA (#14901)
	input.setAttribute( "type", "radio" );
	input.setAttribute( "checked", "checked" );
	input.setAttribute( "name", "t" );

	div.appendChild( input );

<<<<<<< HEAD
	// Support: Safari<=5.1, Android<4.2
	// Older WebKit doesn't clone checked state correctly in fragments
	support.checkClone = div.cloneNode( true ).cloneNode( true ).lastChild.checked;

	// Support: IE<=11+
	// Make sure textarea (and checkbox) defaultValue is properly cloned
	div.innerHTML = "<textarea>x</textarea>";
	support.noCloneChecked = !!div.cloneNode( true ).lastChild.defaultValue;
})();

return support;

});
=======
	// Support: Android <=4.1 only
	// Older WebKit doesn't clone checked state correctly in fragments
	support.checkClone = div.cloneNode( true ).cloneNode( true ).lastChild.checked;

	// Support: IE <=11 only
	// Make sure textarea (and checkbox) defaultValue is properly cloned
	div.innerHTML = "<textarea>x</textarea>";
	support.noCloneChecked = !!div.cloneNode( true ).lastChild.defaultValue;
} )();

return support;

} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

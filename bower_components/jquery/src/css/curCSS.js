<<<<<<< HEAD
define([
=======
define( [
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	"../core",
	"./var/rnumnonpx",
	"./var/rmargin",
	"./var/getStyles",
<<<<<<< HEAD
	"../selector" // contains
], function( jQuery, rnumnonpx, rmargin, getStyles ) {

function curCSS( elem, name, computed ) {
	var width, minWidth, maxWidth, ret,
=======
	"./support",
	"../selector" // Get jQuery.contains
], function( jQuery, rnumnonpx, rmargin, getStyles, support ) {

"use strict";

function curCSS( elem, name, computed ) {
	var width, minWidth, maxWidth, ret,

		// Support: Firefox 51+
		// Retrieving style before computed somehow
		// fixes an issue with getting wrong values
		// on detached elements
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		style = elem.style;

	computed = computed || getStyles( elem );

<<<<<<< HEAD
	// Support: IE9
	// getPropertyValue is only needed for .css('filter') (#12537)
	if ( computed ) {
		ret = computed.getPropertyValue( name ) || computed[ name ];
	}

	if ( computed ) {
=======
	// getPropertyValue is needed for:
	//   .css('filter') (IE 9 only, #12537)
	//   .css('--customProperty) (#3144)
	if ( computed ) {
		ret = computed.getPropertyValue( name ) || computed[ name ];
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

		if ( ret === "" && !jQuery.contains( elem.ownerDocument, elem ) ) {
			ret = jQuery.style( elem, name );
		}

<<<<<<< HEAD
		// Support: iOS < 6
		// A tribute to the "awesome hack by Dean Edwards"
		// iOS < 6 (at least) returns percentage for a larger set of values, but width seems to be reliably pixels
		// this is against the CSSOM draft spec: http://dev.w3.org/csswg/cssom/#resolved-values
		if ( rnumnonpx.test( ret ) && rmargin.test( name ) ) {
=======
		// A tribute to the "awesome hack by Dean Edwards"
		// Android Browser returns percentage for some values,
		// but width seems to be reliably pixels.
		// This is against the CSSOM draft spec:
		// https://drafts.csswg.org/cssom/#resolved-values
		if ( !support.pixelMarginRight() && rnumnonpx.test( ret ) && rmargin.test( name ) ) {
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

			// Remember the original values
			width = style.width;
			minWidth = style.minWidth;
			maxWidth = style.maxWidth;

			// Put in the new values to get a computed value out
			style.minWidth = style.maxWidth = style.width = ret;
			ret = computed.width;

			// Revert the changed values
			style.width = width;
			style.minWidth = minWidth;
			style.maxWidth = maxWidth;
		}
	}

	return ret !== undefined ?
<<<<<<< HEAD
		// Support: IE
=======

		// Support: IE <=9 - 11 only
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		// IE returns zIndex value as an integer.
		ret + "" :
		ret;
}

return curCSS;
<<<<<<< HEAD
});
=======
} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

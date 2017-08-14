<<<<<<< HEAD
define([
	"../var/support"
], function( support ) {

support.focusinBubbles = "onfocusin" in window;

return support;

});
=======
define( [
	"../var/support"
], function( support ) {

"use strict";

support.focusin = "onfocusin" in window;

return support;

} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

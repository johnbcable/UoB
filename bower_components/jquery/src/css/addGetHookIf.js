<<<<<<< HEAD
define(function() {

function addGetHookIf( conditionFn, hookFn ) {
=======
define( function() {

"use strict";

function addGetHookIf( conditionFn, hookFn ) {

>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	// Define the hook, we'll check on the first run if it's really needed.
	return {
		get: function() {
			if ( conditionFn() ) {
<<<<<<< HEAD
=======

>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
				// Hook not needed (or it's not possible to use it due
				// to missing dependency), remove it.
				delete this.get;
				return;
			}

			// Hook needed; redefine it so that the support test is not executed again.
<<<<<<< HEAD
			return (this.get = hookFn).apply( this, arguments );
=======
			return ( this.get = hookFn ).apply( this, arguments );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		}
	};
}

return addGetHookIf;

<<<<<<< HEAD
});
=======
} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

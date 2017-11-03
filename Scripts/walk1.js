var fs = require('fs');
var path = require('path');
var walk = require('fs-walk');

var processNode = function(basedir, filename, stat) {
    // var perm = stat.isDirectory() ? 0755 : 0644;
    var fullname = path.join(basedir, filename);
    var fullparts = fullname.split("\\");

    var curdir = fullparts[3];
    if (stat.isDirectory()) {
    	walk.walkSync(fullname,  processNode );
    } else {
    	// OK we have a file 
    	// Get relevant details from it and out put to console
    	var candidate = fullparts[6];
    	var filedir = fullparts[7];
    	var thefile = fullparts[8];
    	var textline = candidate+",'"+filedir+"','"+thefile+"'\r\n";

		fs.appendFileSync('WLdocs.csv', textline);

    	// console.log(textline);
    }
};

walk.walkSync('c:\\Work\\WorkLinkRawData\\WorkLinkFiles', processNode);

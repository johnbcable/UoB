var fs = require('fs');
var Path = require('path');

// Now initialise the directory split character(s)
// OS dependent:  \\\ for Windows; / for UNIX-like environments
var splitter = '\\';

function WalkDirs(dirPath) {
	console.log(dirPath);
	fs.readdir(dirPath, function(err, entries) {
		for (var idx in entries ) {
			var fullPath = Path.join(dirPath, entries[idx]);
			(function (fullPath) {
				fs.stat(fullPath, function(err, stats) {
					if (stats && stats.isFile()) {

					    var fullparts = fullPath.split(splitter);

					    // The next processing is dependent on where in that tree
					    // you want to start recording information from

				    	var candidate = fullparts[2];
    					var filedir = fullparts[3];
    					var thefile = fullparts[4];
    					var textline = candidate+",'"+filedir+"','"+thefile+"'\r\n";

						fs.appendFileSync('WLdocs.csv', textline);

						console.log(fullPath);
					} else if (stats && stats.isDirectory()) {
						WalkDirs(fullPath);
					}
				});
			}) (fullPath);
		}
	});
}
WalkDirs("c:\\Work\\WorkLinkRawData\\WorkLinkFiles");

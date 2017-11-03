var fs = require('fs');
var out;
var args;
/**
 * To parse directory structure given a starting point - recursive
 */
function traverseDirectory(startDir, usePath, callback) {
    if (arguments.length === 2 && typeof arguments[1] === 'function') {
        callback = usePath;
        usePath = false;
    }
    //Hold onto the array of items
    var parsedDirectory = [];
    //start reading a list of whats contained
    fs.readdir(startDir, function(err, dirList) {

        if (usePath) {
            startDir = fs.realpathSync(startDir);
        }
        if (err) {
            return callback(err);
        }
        //keep track of how deep we need to go before callback
        var listlength = dirList.length;
        if (!listlength) {
            return callback(null, parsedDirectory);
        }
        //loop through the directory list
        dirList.forEach(function(file) {
            file = startDir + '/' + file;
            fs.stat(file, function(err, stat) {
                //note the directory or file
                parsedDirectory.push(file);
                //recursive if this is a directory
                if (stat && stat.isDirectory()) {
                    //recurse
                    traverseDirectory(file, function(err, parsed) {
                        // read this directory into our output
                        parsedDirectory = parsedDirectory.concat(parsed);
                        //check to see if we've exhausted our search
                        if (!--listlength) {
                            callback(null, parsedDirectory);
                        }
                    });
                } else {
                    //check to see if we've exhausted the search
                    if (!--listlength) {
                        callback(null, parsedDirectory);
                    }
                }
            });
        });
    });
}
//Normalize the arguments
args = process.argv.splice(2);
//loop through the directories
args.forEach(function(arg) {
    // use provided path
    traverseDirectory(arg, function(err, result) {
        if (err) {
            console.log(err);
        }
        console.log(result);
    });
    //use full path
    traverseDirectory(arg, true, function(err, result) {
        if (err) {
            console.log(err);
        }
        console.log(result);
    });
});

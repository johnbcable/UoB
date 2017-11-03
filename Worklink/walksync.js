     // List all files in a directory in Node.js recursively in a synchronous fashion
     var walkSync = function(dir, filelist) {
            var path = path || require('path');
            var fs = fs || require('fs'),
                files = fs.readdirSync(dir);
            filelist = filelist || [];
            files.forEach(function(file) {
                if (fs.statSync(path.join(dir, file)).isDirectory()) {
                    filelist = walkSync(path.join(dir, file), filelist);
                }
                else {
                    filelist.push(path.join(dir, file));
                }
            });
            return filelist;
        };

//Normalize the arguments
args = process.argv.splice(2);
//loop through the directories
args.forEach(function(arg) {
    console.log(arg);
    // use provided path
    var results = walkSync(arg, results);
        console.log(results);
    });
});

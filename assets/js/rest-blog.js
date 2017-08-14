/*
invokeService

Parameters
----------
server      - The server/host name
endpoint    - The rest endpoint
querystring - The HTML query string.  This string can include query
              parameters and a variety of filters that control the
response from the service.
username    - The fusion user with privileges to invoke REST APIs
password    - The user's password
requestDiv  - DOM element to display the request URI
responseDiv - DOM element to display the formatted response

Returns
-------
This function does not return anything.


Description
-----------
This is the main function that is called to invoke HCM REST Services.  The function builds the request URI (Universal Resource Identifier) using the server, endpoint and query string and displays the formatted URI string in the browser console and in the requestDiv element. 

A handler is created that will be called when the complete response from the service is received.  The response handler calls the JSON parse function to convert the response text to a JavaScript object.  The code uses this object to retrieve the number of records returned in the response.  The handler also calls the JSON stringify function to convert the response to a more readable string.  The string is then formatted so that it can be properly displayed in HTML.  The number of records retrieved and the formatted response are logged to the browser console and displayed in the responseDiv element.

Finally, the function calls the sendGetRequest() function, passing the request URI, credentials and response handler.

*/
function invokeService(server, endpoint, querystring, username, password, requestDiv, responseDiv) {

    var uri = server + endpoint,
    handler = function() {
        return function (data) {
            var nRecs = '', obj, str;
            if (data) {
                obj = JSON.parse(data);
                str = JSON.stringify(data);
                str = str.substring(1, str.length - 1)
                           .replace(/\\n/g, '<br/>')
                           .replace(/\\"/g, '"');

                if (obj && obj.count) {
                    nRecs = 'Number of records returned: ' + obj.count;
                    console.log(nRecs);

                    nRecs = nRecs + '<p>More records available? ' + (obj.hasMore ? 'Yes' : 'No') + '</p>';
                }

                str = (nRecs ? '<p>' + nRecs + '</p>' + str : str);
            }
            else {
                str = 'An error occurred.  Ensure the Request URI, username and password are correct';
            }

            console.log(data ? data : str);

            responseDiv.innerHTML = str;
        };
    }();

    if (querystring) {
        uri = uri + querystring;
    }

    requestDiv.innerHTML = uri;

    sendGetRequest(uri, username, password, handler);
}

/*
sendGetRequest

Parameters
----------
uri         - The request URI
username    - The fusion user with privileges to invoke REST APIs
password    - The user's password
handler     - the response handler function

Returns
-------
This function does not return anything.

Description
-----------
This function does the work of sending an HTTP GET request to the the rest endpoint on the server (the URI).  First, we call a function to create an XMLHttpRequest object.  The XMLHttpRequest object is used to send an asynchronous request to the server. 

The onreadystatechange function is created and assigned to the request object.  This function will be called asynchronously as response data is returned.  We pass our handler as a parameter to this function, creating whats known as a closure in JavaScript.  The Mozilla Development Network defines closures as:

"Closures are functions that refer to independent (free) variables (variables that are used locally, but defined in an enclosing scope). In other words, these functions 'remember' the environment in which they were created."

What this means is that the response handler function we created in the invokeService function and passed to this function will remember the variables referenced (e.g. responseDiv) when the handler was created.  

The onreadystatechange function is called progressively each time state changes.  The meaning of each state is as follows:

0 - UNSENT
1 - OPENED
2 - HEADERS_RECEIVED
3 - LOADING
4 - DONE

When the state changes to 4, communication with the server is complete.  The HTTP status is also returned along with each state change.  If the request is complete (state = 4 or  XMLHttpRequest.DONE) and the HTTP status is 200 (Success), then we call the handler method passing the responseText as a parameter to us to display the response in our HTML page. 

Note: Since the content type is set to application/json the response is returned in XMLHttpRequest.responseText NOT XMLHttpRequest.responseXML.

Next, we call the XMLHttpRequest open method to initialize the request with the HTTP GET method and the URI.  The last parameter to the this method indicates how the request should be processed.  Passing null indicates we want to process the response asynchronously.

Once the request is initialized, we can set the credentials in the Authentication HTTP header.  We call our setCredentials function to accomplish this. 

Note: There is a variation of the XMLHttpRequest open method that accepts a username and password.  The HCM REST services expect these values to be concatenated and base64 encoded, so we must set them explicitly.

Finally, we send the request to the server.  We pass null to the XMLHttpRequest send method because we are sending a GET request.  If this were a POST request, we would send the POST data as a parameter.

*/
function sendGetRequest(uri, username, password, handler) {
    var req = getXmlRequest()
    if (req == null) {
        console.log('Failed to get XMLHttpRequest object');
        return;
    }

    req.onreadystatechange = function(fn) {
        return function () {
            var status = ('readyState: ' + req.readyState + ', ' +
                          'status: ' + req.status + ' ' + req.statusText);
            console.log(status);

            if (req.readyState === XMLHttpRequest.DONE) {
                if (req.status === 200) {
                    fn(req.responseText);
                }
                else {
                    fn('');
                }            
            }
        };
    }(handler);

    req.open('GET', uri, true);

    if (username && password) {
        setCredentials(req, username, password);
    }

    req.send(null);
}

/*
setCredentials

Parameters
----------
req         - The initialized XMLHttpRequest object
username    - The fusion user with privileges to invoke REST APIs
password    - The user's password

Returns
-------
This function does not return anything.

Description
-----------
This function base64 encodes the username and password and sets the resulting string in the HTTP Basic Authentication header.

*/
function setCredentials(req, username, password) {
    var creds = window.btoa(username + ':' + password);
    req.setRequestHeader('Authorization', 'Basic ' + creds);
}    

/*
getXmlRequest

Parameters
----------
none

Returns
-------
XMLHttpRequest object

Description
-----------
This function creates and returns an XMLHttpRequest object that is compatible with the user's browser.

*/
function getXmlRequest() {
    var e1, e2;

    if (window.XMLHttpRequest) {
        return new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        try {
            return new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e1) {
            try {
                return new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e2) {
                // fall through
            }                    
        }
    }
    return null;
}

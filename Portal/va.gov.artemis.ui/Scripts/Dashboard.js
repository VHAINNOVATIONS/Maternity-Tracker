function sortEDD(element, sortAttr) {
    var patients = $("#patient_divs .patient_div");

    patients.sort(function (a, b) {
        var first = 1;
        var second = -1;

            if (sortAttr == "data-edd")
            {
                a = parseInt(a.getAttribute(sortAttr), 10);
                b = parseInt(b.getAttribute(sortAttr), 10);
            }
            else if (sortAttr == "data-last-name") 
            {
                a = a.getAttribute(sortAttr); 
                b = b.getAttribute(sortAttr);
                first = -1;
                second = 1; 
            }

            if (a < b) {
                return first;
            } else if (a > b) {
                return second;
            } else {
                return 0;
            }
        });

    $("#patient_divs").append(patients);

    if (element.id != "eddSort")
        document.getElementById("eddSort").className = "badge badge-light x-inline";

    if (element.id != "nameSort")
        document.getElementById("nameSort").className = "badge badge-light x-inline";

    if (element.id != "contactSort")
        document.getElementById("contactSort").className = "badge badge-light x-inline";

    element.className = "badge badge-success x-inline";

};

function toggleFilter(element) {
    if (element.className == "badge badge-light")
    { element.className = "badge badge-success"; }
    else
    { element.className = "badge badge-light"; }
};

function testConnection() {

    var request = XMLHttpRequest();
        
    request.onreadystatechange=function()
    {
        if (request.readyState == 4 && request.status == 200) {

            document.getElementById("loading").style.display = "none";
            if (request.responseText == "true")
                document.getElementById("testResult-success").style.display = "block";
            else 
                document.getElementById("testResult-fail").style.display = "block";
            
        }
    }
    
    document.getElementById("testResult-success").style.display = "none";
    document.getElementById("testResult-fail").style.display = "none";
    document.getElementById("loading").style.display = "inline"; 

    var server = document.getElementById("ServerName").value;
    var port = document.getElementById("ListenerPort").value;
    var root = document.getElementById("TestRoot").value;
    
    var url = root + "?ServerName=" + server + "&ServerPort=" + port;

    request.open("POST", url, true);
    request.send();
}

jQuery(function ($) { $("a").tooltip() });

function getJSDate(userDate) {
    var returnDate;
    var parts = userDate.split("/");
    if (parts.length == 3) {
        if (parts[2].length == 2) parts[2] = "20" + parts[2];
        if (parts[2].length == 1) parts[2] = "200" + parts[2];
        var m = Number(parts[0]) - 1;
        if (m > -1) {
            returnDate = new Date(parts[2], m, parts[1]);
            if (isNaN(returnDate.getTime()))
                returnDate = null;
        }
    }
    return returnDate;
};

function getFormattedDate(date) {
    var d = date.getDate();
    var m = date.getMonth() + 1;
    var y = date.getFullYear();
    return (m <= 9 ? '0' + m : m) + '/' + (d <= 9 ? '0' + d : d) + '/' + y;
};




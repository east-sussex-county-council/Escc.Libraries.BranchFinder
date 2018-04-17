if (typeof jQuery !== 'undefined') {
    "use strict";
    $(function () {
            if (typeof (esccGoogleMaps) !== 'undefined') esccGoogleMaps.loadGoogleMapsApi({ callback: "createLibrariesMap" });
        });
    }

function createLibrariesMap() {
    var map = esccGoogleMaps.createMap();

    var infoWindow = new google.maps.InfoWindow({ maxWidth: 200 });

    // Use code from https://github.com/johnkpaul/jquery-ajax-retry to mitigate against network errors, which are the main
    // cause of no JavaScript according to gov.uk research https://gds.blog.gov.uk/2013/10/21/how-many-people-are-missing-out-on-javascript-enhancement/
    //
    // Add vary={origin} to querystring as setting Vary header from view is getting overridden. Need to vary the response by origin somehow, otherwise it requests the alerts
    // from Origin A, caches the response with a CORS header allowing Origin A, then requests the alerts from Origin B, gets the cached version and fails the CORS test.
    var libraryDataUrl = $("[data-libraries-url]").data("libraries-url");
    if (!libraryDataUrl) return;

    $.ajax({ dataType: "json", url: libraryDataUrl + "&vary=" + document.location.protocol + "//" + document.location.host }).retry({ times: 3 }).then(function (data) {

        var libraries = data;
        var bounds = new google.maps.LatLngBounds();

        for (var i = 0; i < libraries.length; i++) {

            // Place a marker for this library on the map
            var coords = new google.maps.LatLng(libraries[i].Latitude, libraries[i].Longitude);

            libraries[i].marker = new google.maps.Marker({
                position: coords,
                map: map,
                title: libraries[i].Name,
                description: libraries[i].Description,
                url: libraries[i].Url
            });

            // Open an InfoWindow with a clickable link when a library is clicked
            libraries[i].marker.addListener('click', function () {
                infoWindow.setContent("<h2><a href=\"" + this.url + "\">" + this.title + "</a></h2>" + this.description);
                infoWindow.open(map, this);
            });

            // Include this marker when we resize the map to show all markers
            bounds.extend(coords);
        }

        // Resize the map to show all markers
        map.fitBounds(bounds);

        // Update the number of libraries in the county based on the number found
        document.getElementById('total-libraries').innerText = libraries.length;
    });
}
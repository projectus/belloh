function initialize_welcome_page(){

    initialize_sidebar();

    $('[rel=tooltip]').tooltip();
}

function initialize_sidebar() {

    setMap();
    initialize_fullscreen_map();

    $('#map').attr('href','#mapfull').attr("data-toggle", "modal").css('cursor', 'pointer');
    
    $("#current-location").click(function(){
        getLocation(getPostsForLocation);
    });

    $("#current-location").bind("mouseover", function(){
        $(this).css("opacity", "1");
    }).bind("mouseout", function(){
        $(this).css("opacity", "0.9");
    });

    $("#all-locations").click(function(){
        var world = {
            "coords": {
                "latitude": "",
                "longitude": ""
            }
        }
        document.getElementById("geostatus").innerHTML="Getting posts from world.";
        getPostsForLocation(world);
    });

    $("#all-locations").bind("mouseover", function(){
        $(this).css("opacity", "1");
    }).bind("mouseout", function(){
        $(this).css("opacity", "0.9");
    });
}

function initialize_fullscreen_map() {
    var map = null;
    var marker = null;
    var post_longitude=document.getElementById("post_longitude");
    var post_latitude=document.getElementById("post_latitude");

    $('#mapfull').on('shown',function () {
        var latlng = new google.maps.LatLng(post_latitude.value,post_longitude.value);
        if (map) {
            map.setCenter(latlng);
            marker.setPosition(latlng);
        } else {
            var mapOptions = {
                zoom: 8,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                size: new google.maps.Size(400, 400, 'px', 'px')
            };

            map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions);

            marker = new google.maps.Marker({
                position: latlng,
                map: map
            });
        }
    });
}

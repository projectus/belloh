function initialize_welcome_page(){

    initialize_sidebar();

    $('#posts').tooltip({
        selector: '[rel=tooltip]'
    });

    $( "#slider" ).slider();
}

function initialize_sidebar() {

    create_fullscreen_link();
    setMap();
    initialize_fullscreen_map();

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

function create_fullscreen_link() {
    var fullscreenlink = document.createElement("a");

    fullscreenlink.id="fullscreen_link";
    fullscreenlink.href="#mapfull";

    $(fullscreenlink).attr("role", "button");

    $(fullscreenlink).attr("data-toggle", "modal");

    var fullscreen = document.createElement("img");

    fullscreen.src = "http://png-1.findicons.com/files/icons/1150/tango/22/view_fullscreen.png";

    $(fullscreen).css({
        "position": "absolute",
        "right": "15px",
        "margin-top": "5px",
        "cursor": 'pointer',
        "opacity": "0.7"
    });

    $(fullscreenlink).append(fullscreen);

    $(".map-div").append(fullscreenlink);

    $(fullscreen).bind("mouseover", function(){
        $(this).css("opacity", "1");
    }).bind("mouseout", function(){
        $(this).css("opacity", "0.7");
    });
}
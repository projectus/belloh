function initialize_welcome_page(){

    initialize_sidebar();
    initialize_filter_bar();
    $('[rel=tooltip]').tooltip();
}

function initialize_filter_bar() {
  $('#filter-bar .nav-pills li').click(function(){
	  var range = $(this).attr('range');
	  $('#filter-bar').find('.active').removeClass('active');
	  $(this).addClass('active');
	  getPostsForRange(range);
	});
}

function initialize_sidebar() {

    $('#map').attr('href','#mapfull').attr("data-toggle", "modal").css('cursor', 'pointer').attr('onload',"$(this).fadeIn(500)");
    setMap();
    initialize_fullscreen_map();
   
    $("#current-location").click(function(){
        getLocation(getPostsForLocation);
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

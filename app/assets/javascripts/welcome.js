function initialize_welcome_page(){

    initialize_sidebar();
    initialize_filter_bar();
    $('[rel=tooltip]').tooltip();

/* for the google location autocomplete dropdown to follow input */
    $(window).scroll(function(){
	    if ($(this).scrollTop() >= 160) {
		    $('.pac-container').css('position','fixed').css('top','60px');
	    } else {
		    $('.pac-container').css('position','absolute').css('top','220px');
	    }
    });
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
/*
		google.maps.event.addListener(map, 'click', function(event) {

		    //if marker exists, erase marker
		    if(singleMarker){
		        singleMarker.setMap(null);
		    }

		    singleMarker = new google.maps.Marker({
		        position: event.latLng, //mouse click position
		        map: map,
		        draggable: true,
		        icon: "http://www.google.com/mapfiles/marker_green.png"
		    });
		});
		*/
}

function initialize_locations_autocomplete() {
	var geostatus=document.getElementById("geostatus");
  var input=document.getElementById('location_search');
  var autocomplete = new google.maps.places.Autocomplete(input);

  google.maps.event.addListener(autocomplete, 'place_changed', function() {

    var place = autocomplete.getPlace();
    if (!place.geometry) {
      // Inform the user that the place was not found and return.
      geostatus.innerHTML = 'location not found';
      return;
    }

    geostatus.innerHTML = 'Getting posts for ' + place.name + '...';
    var location = {
      "coords": {
          "latitude": place.geometry.location.lat(),
          "longitude": place.geometry.location.lng()
      }
    };

    getPostsForLocation(location);
	  
	/* Hack to clear the input box */
		$(input).blur();    
		  setTimeout(function(){
		  $(input).val('');
		},10);
  });
}

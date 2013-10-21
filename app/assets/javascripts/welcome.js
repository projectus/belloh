function initialize_welcome_page(){

    initialize_sidebar();
    initialize_filter_bar();
    $('body').tooltip({
        selector: '[rel=tooltip]'
    });

    $(window).scroll(function(){

        /* for the google location autocomplete dropdown to follow input */
        if ($(this).scrollTop() >= 160) {
            $('.pac-container').css('position','fixed').css('top','60px');
        } else {
            $('.pac-container').css('position','absolute').css('top','220px');
        }

        /* infinite scroll. if next-page link is in view, click it and remove it from the DOM */
        var next = $('#next-page a[rel=next]');
        if (next.length) {
            if( isScrolledIntoView(next) ) {
                next.click();
                next.remove();
            }
        }
    });
}

function isScrolledIntoView(elem)
{
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height() + 1000;

    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
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

function getRange() {
  var pill = $('#filter-bar').find('.active');
  if (pill.length) return pill.attr('range'); else return null; 	
}

function initialize_fullscreen_map() {
    var map = null;
    var marker = null;
    var circle = null;
    var post_longitude=document.getElementById("post_longitude");
    var post_latitude=document.getElementById("post_latitude");

    $('#mapfull').on('shown',function () {
      var lat = post_latitude.value;
      var lng = post_longitude.value;

      var latlng = null;
      var zoom = 1;
      var radius = 0;

      if (lat && lng) {
        latlng = new google.maps.LatLng(lat,lng);

        var range = getRange();

        if (range == 'near') {
          zoom = 18;
          radius = 50;
        } else if (range == 'mid') {
          zoom = 15;
          radius = 500;
        } else if (range == 'far') {
          zoom = 12;
          radius = 5000;
        }
      } else {
	      latlng = new google.maps.LatLng(0,0);
      }

      if (map) {
          map.setCenter(latlng);
          marker.setPosition(latlng);
          map.setZoom(zoom);
          circle.setRadius(radius);
      } else {
        var mapOptions = {
          zoom: zoom,
          center: latlng,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions);

        marker = new google.maps.Marker({
          position: latlng,
          draggable: true,
          map: map
        });

        circle = new google.maps.Circle({
          radius: radius,
          fillColor: 'green',
          map: map,
        });
        circle.bindTo('center', marker, 'position');
      }
    });

    $('#pinpoint').on('click',function(){
	    if (marker) {
		    var pos = marker.getPosition();
		    var coords = {
            "coords": {
                "latitude": pos.lat(),
                "longitude": pos.lng()
            }
        }
		    getPostsForLocation(coords);
      }
	  });
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

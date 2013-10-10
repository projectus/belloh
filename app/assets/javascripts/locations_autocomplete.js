function initialize_locations_autocomplete() {
	var geostatus=document.getElementById("geostatus");
  var input=document.getElementById('location_search');
  var autocomplete = new google.maps.places.Autocomplete(input);

  google.maps.event.addListener(autocomplete, 'place_changed', function() {

    var place = autocomplete.getPlace();
    if (!place.geometry) {
      // Inform the user that the place was not found and return.
      geostatus.innerHTML = 'hub not found';
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
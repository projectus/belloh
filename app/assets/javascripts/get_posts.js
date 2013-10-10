function getPostsForLocation(location) {
  var lat=location.coords.latitude;
	var lon=location.coords.longitude;
	var the_data = 'lat=' + encodeURIComponent(lat)
               +'&lon=' + encodeURIComponent(lon);

  setMap(lat,lon);
  post_latitude.value=lat;
  post_longitude.value=lon;
	$.ajax({
	  data: the_data,
	  dataType: 'script',
	  type: 'get',
	  url: '/posts'
	});
}
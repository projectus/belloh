function getPostsForLocation(location) {
  var lat=location.coords.latitude;
	var lng=location.coords.longitude;
	var the_data = 'lat=' + encodeURIComponent(lat)
               +'&lng=' + encodeURIComponent(lng);

  setMap(lat,lng);
  post_latitude.value=lat;
  post_longitude.value=lng;
	$.ajax({
	  data: the_data,
	  dataType: 'script',
	  type: 'get',
	  url: '/posts'
	});
}
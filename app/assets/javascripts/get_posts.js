function getPostsForLocation(location) {
  var lat=location.coords.latitude;
  var lng=location.coords.longitude;
  var the_data = 'lat=' + encodeURIComponent(lat)
               +'&lng=' + encodeURIComponent(lng);

  document.getElementById("post_latitude").value=lat;
  document.getElementById("post_longitude").value=lng;

  $.ajax({
    data: the_data,
    dataType: 'script',
    type: 'get',
    url: '/posts'
  });
}
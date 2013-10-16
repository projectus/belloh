function getPostsForLocation(location) {
  var lat=location.coords.latitude;
  var lng=location.coords.longitude;
  var the_data = 'lat=' + encodeURIComponent(lat)
               +'&lng=' + encodeURIComponent(lng);

  //document.getElementById("post_latitude").value=lat;
  //document.getElementById("post_longitude").value=lng;
  document.getElementById("filter").value='';

  $.ajax({
    data: the_data,
    dataType: 'script',
    type: 'get',
    url: '/posts'
  });
}

function getPostsForRange(range) {
  var filter = document.getElementById("filter").value;

  var the_data = 'range=' + encodeURIComponent(range)
               + '&filter=' + encodeURIComponent(filter);

  $.ajax({
    data: the_data,
    dataType: 'script',
    type: 'get',
    url: '/posts'
  });
}
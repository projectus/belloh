function setMap(lat,lon) {
	var latlon = lat+","+lon;
	var srcString = "http://maps.googleapis.com/maps/api/staticmap?center="
	+latlon+"&zoom=12&size=185x185&sensor=false&markers=|"+latlon;
	if (lat=="nil") srcString = "assets/tiles/globe.png";
  $("#map").attr("src", srcString);

  var fullscreenlink = document.createElement("a")

  fullscreenlink.href="#mapfull";

  $(fullscreenlink).attr("role", "button")

  $(fullscreenlink).attr("data-toggle", "modal")

  var fullscreen = document.createElement("img")

  fullscreen.src = "http://png-1.findicons.com/files/icons/1150/tango/22/view_fullscreen.png"

  $(fullscreen).css({
      "position": "absolute",
      "right": "15px",
      "margin-top": "5px",
      "cursor": 'pointer',
      "opacity": "0.7"
  })

  $(fullscreenlink).append(fullscreen)

  $(".map-div").append(fullscreenlink)

  $(fullscreen).bind("mouseover", function(){
      $(this).css("opacity", "1")
  }).bind("mouseout", function(){
      $(this).css("opacity", "0.7")
  })
}
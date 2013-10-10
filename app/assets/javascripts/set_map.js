function setMap(lat,lon) {
	var latlon = lat+","+lon;
	var srcString = "http://maps.googleapis.com/maps/api/staticmap?center="
	+latlon+"&zoom=12&size=210x210&sensor=false&markers=|"+latlon;
	if (lat=="nil") srcString = "assets/tiles/globe.png";
  $("#map").attr("src", srcString);
}

function setMap(lat,lon) {
	var srcString = "http://maps.googleapis.com/maps/api/staticmap?center="+lat+","+lon+"&zoom=12&size=185x185&sensor=false";
	if (lat=="nil") srcString = "assets/tiles/globe.png";
  $("#map").attr("src", srcString);
}
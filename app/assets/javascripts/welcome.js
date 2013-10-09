
// Javascript to fetch user's location and fill with relevant posts
$(function(){
	var post_longitude=document.getElementById("post_longitude");
  var post_latitude=document.getElementById("post_latitude");
	var geostatus=document.getElementById("geostatus");

  setMap(post_latitude.value,post_longitude.value);

	$('#posts').tooltip({
	    selector: '[rel=tooltip]'
	});
	
  $("#current-location").click(function(){
    getLocation(getPostsForLocation);
  });

  $("#all-locations").click(function(){
    var world = {
      "coords": {
          "latitude": "nil",
          "longitude": "nil"
      }
    }
    geostatus.innerHTML="Getting posts from world.";
    getPostsForLocation(world);
  });

	$("#post_mood").change(function() {
    var mood = $("#post_mood option:selected").text().toLowerCase();
    $('#new_post_box').attr('mood',mood);
	});
});







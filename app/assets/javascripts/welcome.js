
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

	function replace_class(affected_id,class_name) {
	  $("#"+affected_id).removeClass();
	  $("#"+affected_id).addClass(class_name);		
  }

	$("#post_mood").change(function() {
    var mood = $("#post_mood option:selected").text().toLowerCase();
    var id = 'new_post_box';
    replace_class(id,'post-'+mood);
	});
});







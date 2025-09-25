platform_x += hspd;
platform_y += vspd;
if (direction_wall == "horizontal") {
	
	x += hspd * direction_flag;


	if (x > start_x + move_distance) {
	    x = start_x + move_distance;
	    direction_flag = -1; 
	}
	else if (x < start_x - move_distance) {
	    x = start_x - move_distance;
	    direction_flag = 1; 
	}

}

else {
	
	y += vspd * direction_flag;


	if (y > start_y + move_distance) {
	    y = start_y + move_distance;
	    direction_flag = -1; 
	}
	else if (y < start_y - move_distance) {
	    y = start_y - move_distance;
	    direction_flag = 1; 
	}
}

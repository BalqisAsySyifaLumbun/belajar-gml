/// Step Event - obj_square_player

var speed_s = 11;


// Respawn check
if (y > room_height + 100) {
    x = respawn_x;
    y = respawn_y;
    hspd = 0;
    vspd = 0;
}

#region death_player
if (hlth <= 0) {
    instance_destroy();
}
#endregion

#region shoot_player
if (alarm[0] <= 0) {
    if (keyboard_check_pressed(ord("Z")) || mouse_check_button_pressed(mb_left)) {
        var dir = point_direction(x, y - sprite_height / 2, mouse_x, mouse_y);
        var x_offset = lengthdir_x(20, dir);
        var y_offset = lengthdir_y(20, dir);
        var flip = (mouse_x > x) * 2 - 1;
        var gun_x = x - 4 * flip;

        var bullet = instance_create_layer(x + x_offset, y - sprite_height / 2 + y_offset, "Instances", obj_bullet);
        bullet.direction = dir;

        // Recoil
        var recoil_dir_back = dir + 180;
        var recoil_dir_up = dir + 180;
        hspd += lengthdir_x(recoil_back_strength, recoil_dir_back);
        vspd = -lengthdir_y(recoil_back_strength, recoil_dir_back);
        vspd -= lengthdir_y(recoil_jump_strength, recoil_dir_up);

        alarm[0] = bullet_cooldown;
    }
}
#endregion

//  Input horizontal
var hinput = keyboard_check(vk_right) - keyboard_check(vk_left);

//  Horizontal movement
if (hinput != 0) {    
    hspd = hinput * acc;
    hspd = clamp(hspd, -max_hspd, max_hspd);
    image_xscale = sign(hinput);
} else {
    hspd = lerp(hspd, 0, 0.3);
}

//  Gravity
vspd += grav;

  //Vertical collision with static walls
if (place_meeting(x, y + vspd, obj_parent_wall)) {
    while (!place_meeting(x, y + sign(vspd), obj_parent_wall)) {
        y += sign(vspd);
    }
    vspd = 0;

     //Jump input
    if (keyboard_check(vk_up)) {
        vspd = -10;
        x_scale = image_xscale * 0.6;
        y_scale = image_yscale * 1.2;
		show_debug_message("Koordinat x: "+ string(x));
		show_debug_message("Koordinat y: "+ string(y));
    }
} else {
    y += vspd;
}



var platform = instance_place(x, y + 1, obj_floating_wall);

if (platform != noone) {
	
	var rel_x = x - platform.x;
    var rel_y = y - platform.y;
    
    show_debug_message("Posisi relatif karakter di platform: "  + string(rel_x) + ", " + string(rel_y));
	
	y = platform.bbox_top - (bbox_bottom - y);
	y += platform.vspd;
    
	var array_vector = [[hspd,vspd],[hspd_push,vspd_push],[platform.hspd,platform.vspd]];
	
	if (platform.direction_wall == "horizontal") {
		x += (platform.hspd * platform.direction_flag);
		
		
		if (!anchored) {
			
			show_debug_message("X: "+string(x));

	        anchored = true;
	        anchor_id = platform.id;
	        rel_x = x - platform.x;
	        rel_y = y - platform.y;
			var width = platform.bbox_right - platform.bbox_left;
			hspd = 0;
			show_debug_message("ANCHORED!");
			show_debug_message("PLATFORM WIDTH: "+string(width)+","+string(platform.bbox_right)+","+string(platform.bbox_left));
			show_debug_message("ANCHORED: "+string(anchor_id)+","+string(rel_x)+","+string(rel_y));
			show_debug_message("PLATFORM SPEED: "+string(anchor_id.hspd));

		}

		
		if (anchored) {
			if (x < anchor_id.bbox_left || x > anchor_id.bbox_right) {
				anchored = false;
				anchor_id = 0;
		        rel_x = 0;
		        rel_y = 0;
				hspd = 0;
				show_debug_message("FREE!");
				show_debug_message("FREE: "+string(rel_x)+","+string(rel_y));
			}
			
			else if (keyboard_check(vk_up)) {
				for (var i = 0; i < array_length(array_vector); i++) {
				    x += array_vector[i][0];
				    y += array_vector[i][1];
				}
				
		    }
		}
    }
}

if (!keyboard_check_pressed(vk_up)) { 
	x += hspd;
}


//Player script
scr_player();

// Squash animation
if (place_meeting(x, y + 1, obj_parent_wall) && !place_meeting(x, yprevious + 1, obj_parent_wall)) {
    x_scale = image_xscale * 1.8;
    y_scale = image_yscale * 0.2;
}

x_scale = lerp(x_scale, image_xscale, 0.3);
y_scale = lerp(y_scale, image_yscale, 0.3);

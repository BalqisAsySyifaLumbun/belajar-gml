/// Step Event - obj_square_player

var speed_s = 11;

var array_vector = [
    [hspd, vspd],
    [hknock, vknock]
];


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

#region horizontal_player
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
#endregion

#region vertical_player
  //Vertical collision with static walls
if (place_meeting(x, y + vspd, obj_parent_wall)) {
    while (!place_meeting(x, y + sign(vspd), obj_parent_wall)) {
        y += sign(vspd);
    }
    vspd = 0;
	on_leap = false;

     //Jump input
    if (keyboard_check(vk_up)) {
        vspd = -15;
        x_scale = image_xscale * 0.6;
        y_scale = image_yscale * 1.2;
		show_debug_message("Koordinat x: "+ string(x));
		show_debug_message("Koordinat y: "+ string(y));
    }
} else {
    y += vspd;
}
#endregion


var platform = instance_place(x, y + 1, obj_floating_wall);

if (platform != noone) {
	
	
	if (x >= platform.bbox_left && x <= platform.bbox_right) {
		on_leap = false;
		var rel_x = x - platform.x;
	    var rel_y = y - platform.y;
	    anchor_id = platform.id;
	    //show_debug_message("Posisi relatif karakter di platform: "  + string(rel_x) + ", " + string(rel_y));
	
		y = platform.bbox_top - (bbox_bottom - y);
		y += platform.vspd;
    
		array_push(array_vector, [platform.hspd, platform.vspd]);
	
		//Supaya bisa jalan di platform bergerak
		if (keyboard_check(vk_left) || keyboard_check(vk_right)){
			x += hspd;
		}
	
		if (platform.direction_wall == "vertical") {
			on_hori_ground = false;
			show_debug_message("VERTICAL");
			
		}
	
		//Khusus yg horizontal
		if (platform.direction_wall == "horizontal") {
			on_hori_ground = true;
			show_debug_message("HORIZONTAL");
			
			x += platform.hspd * platform.direction_flag;
		
		
			if (keyboard_check_pressed(vk_up) && on_hori_ground){
				locked_hspd = platform.hspd * platform.direction_flag;
				on_hori_ground = false;
				on_leap = true;
				show_debug_message("LEAPING");
			
			
			}
		

	    }
	}
	else{
		platform = noone;
	}
}
else{
	on_hori_ground = false;
}

if (on_leap) {
	x += locked_hspd;
}
else{
	locked_hspd = 0;
	x += locked_hspd;
}


//


//Player script
scr_player();

// Squash animation
if (place_meeting(x, y + 1, obj_parent_wall) && !place_meeting(x, yprevious + 1, obj_parent_wall)) {
    x_scale = image_xscale * 1.8;
    y_scale = image_yscale * 0.2;
}

x_scale = lerp(x_scale, image_xscale, 0.3);
y_scale = lerp(y_scale, image_yscale, 0.3);

function scr_jump(){
	   vspd = -10;
	   jump_count -= 1;
	   x_scale = image_xscale * 0.6;
	   y_scale = image_yscale * 1.2;
	   //show_debug_message(string(jump_count));
}

//Khusus untuk melompat di platform bergerak horizontal
function scr_jump_hori(platform){
	   if (jump_count > 0){
		   locked_hspd = (max_jump - jump_count) + (platform.hspd * platform.direction_flag);
	   }
	   
	   vspd = -10;
	   jump_count -= 1;
	   x_scale = image_xscale * 0.6;
	   y_scale = image_yscale * 1.2;
}
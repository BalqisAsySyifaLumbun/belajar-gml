function scr_player(){
	var _hspd_total = hspd+hspd_push;
	var _vspd_total = vspd+vspd_push;
	
	#region move_x
	if (place_meeting(x+_hspd_total,y,obj_parent_wall)){
		while (!place_meeting(x+sign(_hspd_total),y,obj_parent_wall)){
			x += sign(_hspd_total);
		}
		hspd = 0;
		hspd_push = 0;
	}
	x += hspd;
	x += hspd_push;
	#endregion

	#region move_y
	if (place_meeting(x,y+_vspd_total,obj_parent_wall)){
		while (!place_meeting(x,y+sign(_vspd_total),obj_parent_wall)){
			y += sign(_vspd_total);
			//show_debug_message("Koordinat y: "+string(y));
		}
		vspd = 0;
		vspd_push = 0;
	}
	y += vspd;
	y += vspd_push;
	#endregion
	
}
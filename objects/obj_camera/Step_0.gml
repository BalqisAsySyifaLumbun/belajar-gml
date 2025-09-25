if not instance_exists(target) exit;
xTo = target.x;
yTo = target.y;

x += (xTo - x)/25;
y += (yTo - y)/25;
camera_set_view_pos(view_camera[0],x-(width_/2),y-(height_/2));

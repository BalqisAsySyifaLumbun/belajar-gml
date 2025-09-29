window_set_size(1280,720);

#region instance_variable
hspd = 0;
max_hspd = 10;
vspd = 0;
grav = 1;
acc = 6;
jump = 10;
jump_count = 0;
max_jump = 10;
recoil_back_strength = 5; 
recoil_jump_strength = 40;  
hspd_push = 0;
vspd_push = 0;
hlth = 20;
kilct = 0;
hknock = 0;
vknock = 0;
anchored = false; 
anchor_id = noone; 
on_hori_ground = false;
on_leap = false;
locked_hspd = 0;
rel_x = 0;
rel_y = 0;
#endregion

respawn_x = x;
respawn_y = y;

//Kustomisasi setting keypad
#region keyboard_mapping
keyboard_set_map(ord("D"),vk_right);
keyboard_set_map(ord("A"),vk_left);
keyboard_set_map(ord("W"),vk_up);
keyboard_set_map(vk_space,vk_up);
#endregion

x_scale = image_xscale;
y_scale = image_yscale;

//Bullet
#region bullet_cooldown
bullet_cooldown = room_speed/2;
alarm[0] =bullet_cooldown;
#endregion
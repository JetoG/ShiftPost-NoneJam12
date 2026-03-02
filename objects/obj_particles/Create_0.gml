#region PARTICULA NORMAL

// NORMAL
ps_normal = part_system_create();
part_system_depth(ps_normal, 800);

pt_normal = part_type_create();
part_type_shape(pt_normal, pt_shape_pixel);
part_type_size(pt_normal, 1, 2, 0, 0);
part_type_speed(pt_normal, 0.05, 0.15, 0, 0);
part_type_direction(pt_normal, 160, 200, 0, 0);
part_type_gravity(pt_normal, 0, 0);
part_type_colour3(pt_normal, $A8D8FF, $D6F0FF, $FFFFFF);
part_type_alpha3(pt_normal, 0.2, 0.3, 0);
part_type_life(pt_normal, 120, 200);
part_type_blend(pt_normal, false);

pe_normal = part_emitter_create(ps_normal);
part_emitter_region(ps_normal, pe_normal, -240,240,-135,135, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(ps_normal, pe_normal, pt_normal, 1);

part_system_position(ps_normal, room_width/2, room_height/2);


#endregion

#region PARICULA SOMBRIA

// SHADOW
ps_shadow = part_system_create();
part_system_depth(ps_shadow, 800);

pt_shadow = part_type_create();
part_type_shape(pt_shadow, pt_shape_pixel);
part_type_size(pt_shadow, 1, 3, 0, 0.02);
part_type_speed(pt_shadow, 0.02, 0.08, 0, 0);
part_type_direction(pt_shadow, 250, 290, 0, 0);
part_type_gravity(pt_shadow, 0, 0);
part_type_colour3(pt_shadow, $A020F0, $FF4FD8, $FF99FF);
part_type_alpha3(pt_shadow, 0.4, 0.6, 0);
part_type_life(pt_shadow, 100, 180);
part_type_blend(pt_shadow, true); // brilho
part_type_orientation(pt_shadow, 0, 360, 0, 0, true);

pe_shadow = part_emitter_create(ps_shadow);
part_emitter_region(ps_shadow, pe_shadow, -240,240,-135,135, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(ps_shadow, pe_shadow, pt_shadow, 2);

part_system_position(ps_shadow, room_width/2, room_height/2);


#endregion
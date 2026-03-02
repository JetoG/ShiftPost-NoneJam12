// Inherit the parent event
event_inherited();

sprite = spr_double_jump;

collected = function () {
    if (instance_exists(obj_player)) {
        if (collision_rectangle(bbox_left - 3, bbox_top - 3, bbox_right + 2, bbox_bottom, obj_player, false, true) and global.mundo) {
            if (!instance_exists(tlc_e)) {
                tlc_e = instance_create_layer(x, y, "HUD", obj_tlc_e);
            } else {
                with (tlc_e) {
                    image_alpha = lerp(image_alpha, 1, 0.1);
                }
            }
            
            if (keyboard_check_pressed(ord("E"))) {
                with (obj_player) {
                	double_jump = true;
                }
                
                play_sound(snd_dash_double, 0.6);
                instance_destroy();
                
                instance_destroy(tlc_e);
                if (!instance_exists(tlc_e)) {
                    tlc_e = noone;
                } 
            }
        } else {
            if (instance_exists(tlc_e)) {
                with (tlc_e) {
                    image_alpha = lerp(image_alpha, 0, 0.2);
                    
                    if (image_alpha < 0.01) {
                        image_alpha = 0;
                        instance_destroy();
                    }
                }
                
                if (!instance_exists(tlc_e)) {
                    tlc_e = noone;
                }
            }
        }
    }
    if (instance_exists(tlc_e)) {
        with (tlc_e) {
            yfinal = other.ydraw - 15;
        }
    }
}
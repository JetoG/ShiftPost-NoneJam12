timer  = 0;
sprite = spr_batery;
tlc_e  = noone;
ydraw  = ystart;

collected = function () {
    if (instance_exists(obj_device) and instance_exists(obj_player)) {
        if (collision_rectangle(bbox_left - 3, bbox_top - 3, bbox_right + 2, bbox_bottom, obj_player, false, true) and !global.mundo) {
            if (!instance_exists(tlc_e)) {
                tlc_e = instance_create_layer(x, y, "HUD", obj_tlc_e);
            } else {
                with (tlc_e) {
                    image_alpha = lerp(image_alpha, 1, 0.1);
                }
            }
            
            if (keyboard_check_pressed(ord("E"))) {
                instance_destroy();
                play_sound(snd_batery, .8);
                with (obj_device) {
                    cargas += other.cargas;
                    cargas_inicial = cargas;
                }
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

exists = function () {
    if (sombrio and global.mundo) {
        sprite_index = sprite;
    } else if (sombrio and !global.mundo) {
        sprite_index = spr_noone;    
    } else if (!sombrio and global.mundo) {
        sprite_index = spr_noone;
    } else if (!sombrio and !global.mundo) {
        sprite_index = sprite;
    }
}
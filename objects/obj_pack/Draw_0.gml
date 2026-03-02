if (image_index == 0) {
    draw_self();
} else {
    draw_sprite_ext(sprite_index, image_index, x, ydraw, image_xscale, image_yscale, image_angle, image_blend, image_alpha);;
}


if (collision_rectangle(bbox_left - 3, bbox_top - 3, bbox_right + 2, bbox_bottom, obj_player, false, true) and !global.mundo) {
    if (!instance_exists(tlc_e)) {
        tlc_e = instance_create_layer(x, y, "HUD", obj_tlc_e);
    } else {
        with (tlc_e) {
            image_alpha = lerp(image_alpha, 1, 0.1);
        }
    }
    if (keyboard_check_pressed(ord("E"))) {
        if (instance_exists(obj_player)) {
            play_sound(snd_package, 0.8);
            obj_player.encomenda = true;
            instance_destroy();
            instance_destroy(tlc_e);
            if (!instance_exists(tlc_e)) {
                tlc_e = noone;
            }
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
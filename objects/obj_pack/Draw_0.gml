draw_self();

if (collision_rectangle(bbox_left - 3, bbox_top - 3, bbox_right + 2, bbox_bottom, obj_player, false, true)) {
    if (!instance_exists(obj_tlc_e)) {
        instance_create_layer(x, y, "Paredes", obj_tlc_e);
    } else {
        with (obj_tlc_e) {
            image_alpha = lerp(image_alpha, 1, 0.1);
        }
    }
    if (keyboard_check_pressed(ord("E"))) {
        if (instance_exists(obj_player)) {
            obj_player.encomenda = true;
            instance_destroy();
        }
    }
} else {
    if (instance_exists(obj_tlc_e)) {
        with (obj_tlc_e) {
            image_alpha = lerp(image_alpha, 0, 0.2);
            
            if (image_alpha < 0.01) {
                image_alpha = 0;
                instance_destroy();
            }
        }
    }
}
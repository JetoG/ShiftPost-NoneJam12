if (room == rm_menu) {
    if (keyboard_check_pressed(vk_escape)) {
        game_end();
    }
    if (!instance_exists(obj_teleport) or obj_teleport.image_index < 6) {
        draw_menu();
        controla_menu();
    }
} else {
    if (room != rm_fase_10) {
        if (global.pause) {
            if (!instance_exists(obj_teleport) or obj_teleport.image_index < 6) {
                controla_m_restart();
                draw_m_restart();
            }
        }
    } else {
        draw_thanks();
        if (keyboard_check_pressed(vk_escape)) {
            Transition(rm_menu);
            DeleteGame();
            level = CheckActualLevel();
            if (level > 0) {
                menu = ["Continuar", "Iniciar"];
            } else {
                menu = ["Iniciar"];
            }
            menu_scale = array_create(array_length(menu), 0.5);
            menu_angle = array_create(array_length(menu), 0);
        }
    }
}
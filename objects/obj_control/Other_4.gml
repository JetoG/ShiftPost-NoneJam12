if (!audio_is_playing(snd_thema)) {
    audio_play_sound(snd_thema, 1, true, 0.3);
}
switch (room) {
	case rm_fase_1:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_2:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 5;
            _hud.cargas = 5;
        }
    break;
    case rm_fase_3:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_4:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_5:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_6:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_7:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_8:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_9:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 101, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_fase_10:
        if (!instance_exists(obj_device)) {
            var _hud = instance_create_layer(2, 2, "HUD", obj_device);
            _hud.cargas_inicial = 12;
            _hud.cargas = 12;
        }
    break;
    case rm_menu:
        global.pause = false;
        global.mundo = false;
    break;
}
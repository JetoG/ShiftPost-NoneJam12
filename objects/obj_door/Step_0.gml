if (global.mundo) {
    image_blend = c_dkgray;
    image_alpha = 0.5;
} else {
    image_blend = c_white;
    image_alpha = 1;
}

if (instance_exists(obj_player)) {
    var _pl = instance_place(x, y, obj_player);
    if (_pl and _pl.encomenda and !global.mundo) {
        if (!clear) {
            obj_control.ClearFase();
            clear = true;
            play_sound(snd_door, 2);
        }
        instance_destroy(_pl);
    }
}
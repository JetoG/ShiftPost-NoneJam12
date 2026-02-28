timer = 0;
sprite = spr_batery;

collected = function () {
    if (instance_exists(obj_device) and instance_exists(obj_player)) {
        if (instance_place(x, y, obj_player)) {
            instance_destroy();
            with (obj_device) {
                cargas += other.cargas;
                cargas_inicial = cargas;
            }
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
if (!restart) {
    if (instance_exists(obj_player)) {
        obj_player.tp = noone;
    }
} else {
    global.mundo = false;
    room_restart();
}

if (menu) {
    room_goto(room_tg);
}

instance_destroy();
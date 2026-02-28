if (instance_exists(obj_player)) {
    var _pl = instance_place(x, y, obj_player);
    if (_pl and _pl.encomenda) {
        room_goto_next();
    }
}
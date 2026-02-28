// Inherit the parent event
event_inherited();

sprite = spr_double_jump;

collected = function () {
    if (instance_exists(obj_player)) {
        if (instance_place(x, y, obj_player)) {
            instance_destroy();
            with (obj_player) {
                double_jump = true;
            }
        }
    }
}
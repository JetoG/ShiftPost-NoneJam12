if (!instance_exists(obj_teleport)) {
    obj_player.tp = instance_create_layer(obj_player.x, obj_player.y - (sprite_get_height(spr_player_idle) / 2), "HUD", obj_teleport, {start: true});
    obj_player.velh = 0;
    obj_player.velv = 0;
}
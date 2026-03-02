if (!start) {
    if (image_index == 6) {
        global.mundo = !global.mundo; 
        layer_set_visible(layer_get_id("Sombrio"), global.mundo);
        layer_set_visible(layer_get_id("SombrioExtras"), global.mundo);
        layer_set_visible(layer_get_id("BgSombrio"), global.mundo);
        layer_set_visible(layer_get_id("BgSombrioParallax"), global.mundo);
        layer_set_visible(layer_get_id("Normal"), !global.mundo);
        layer_set_visible(layer_get_id("NormalExtras"), !global.mundo);
        layer_set_visible(layer_get_id("BgNormal"), !global.mundo);
    }
    
    if (instance_exists(obj_player)) {
        x = obj_player.x;
        y = obj_player.y - (sprite_get_height(spr_player_idle) / 2);
    }
} else {
    if (!menu) {
        if (image_index == 6) {
            if (!instance_exists(obj_player)) {
                instance_create_layer(x, y + (sprite_get_height(spr_player_idle) / 2), "Player", obj_player, {image_xscale: image_xscale});
                obj_player.tp = id;
            } else {
                restart = true;
                instance_destroy(obj_player);    
            } 
        }
    }
}

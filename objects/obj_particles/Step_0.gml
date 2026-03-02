if (!global.mundo) {
    part_system_automatic_draw(ps_normal, true);
    part_system_automatic_draw(ps_shadow, false);
} else {
    part_system_automatic_draw(ps_normal, false);
    part_system_automatic_draw(ps_shadow, true);
}
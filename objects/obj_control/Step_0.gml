upd_screenshake();

if (keyboard_check_pressed(ord("R"))) {
    room_restart();
    global.mundo = false;    
}
cargas_d = lerp(cargas_d, cargas, 0.15);
    
if (abs(cargas_d - cargas) < 0.01) {
    cargas_d = cargas;
}

var _speed = max(0.05, cargas_inicial * 0.01);

cargas_g = approach(cargas_g, cargas, _speed);
cargas_g = clamp(cargas_g, 0, cargas_inicial);

if (place_meeting(x, y, [obj_player, obj_batery, obj_door, obj_pack])) {
    image_alpha = 0.3;
} else {
    image_alpha = 1;
}

if (cargas <= cargas_inicial * 0.2) {
    if (!audio_is_playing(snd_low_baterry)) {
        audio_play_sound(snd_low_baterry, 1, true);
    }
} else {
    if (audio_is_playing(snd_low_baterry)) {
        audio_stop_sound(snd_low_baterry);
    }
}
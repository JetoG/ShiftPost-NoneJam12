// Variáveis
velh = 0;
velv = 0;
mspd = 1.4;
jspd = 3;
dir  = sign(image_xscale);

right = 0;
left  = 0;
jump  = 0;
chao  = noone;
grav  = 0.2;
rglf  = 0;

if (room != rm_fase_10) {
    encomenda   = false;
    double_jump = false;
    has_dash    = false;
} else {
    encomenda   = true;
    double_jump = true;
    has_dash    = true;
}

//Dash
dash_t = game_get_speed(gamespeed_fps) / 4;
t_dash = dash_t;
leng   = 3;
carga  = 1;
dcor   = 255; // Saturação do Dash/Cor
dire   = 0; // Direção do Dash

// Buffer Jump
buff_t  = 6;
buff_tt = 0;

// Coyote Jump
coyo_t  = 6;
coyo_tt = 0;

// Pulos
pulo = 1;

xscale = 1;
yscale = 1;

colisoes = [obj_wall, obj_plat];
sprites  = [spr_player_idle, spr_player_walk, spr_player_fall, spr_player_jump, spr_player_walk];

keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("K"), vk_space);
keyboard_set_map(ord("J"), vk_alt);

inputs = function () {
    if tp return;
        
    up    = keyboard_check(vk_up);
    down  = keyboard_check(vk_down);
    right = keyboard_check(vk_right);
    left  = keyboard_check(vk_left);
    rglf  = right - left;
    updw  = down - up;
    jump  = keyboard_check_pressed(vk_space);
    dash  = keyboard_check_pressed(vk_alt);
};

movement = function () {
    if (rglf != 0) dir = sign(rglf);
        
    if tp return;
    
    velh = rglf * mspd;
    
    if (!chao) {
        velv += grav;
    } else {
        velv = 0;
    }
    
    coyote_buffer_jump();
    velv = clamp(velv, -jspd, jspd * 2);
}

colision = function () {
    // --- HORIZONTAL ---    
    // Sistema de Colisão e Movimentação Horizontal
    repeat (abs(velh)) {
        var _velh = sign(velh);
        
        // Subindo Rampas
        if (place_meeting(x + _velh, y, colisoes) and !place_meeting(x + _velh, y - 1, colisoes)) {
            y--;
        }
        
        // Descendo Rampas
        if (!place_meeting(x + _velh, y, colisoes) and 
            !place_meeting(x + _velh, y + 1 , colisoes) and
            place_meeting(x + _velh, y + 2, colisoes)) {
            y++;
        }
        
        // Checando se vou bater na parede 1 pixel por vez
    	if (place_meeting(x + _velh, y, colisoes)) {
            // Você vai parar
            velh = 0;
            break;
        } else {
            x += _velh;
        }
    }
     
    // --- VERTICAL ---
    y = round(y);
    // Sistema de Colisão e Movimentação Vertical
    if (place_meeting(x, y + velv, colisoes)) {
        // Move pixel a pixel até encostar
        var _velv = sign(velv);
        while (!place_meeting(x, y + _velv, colisoes)) {
            y += _velv;
        }
        velv = 0;
    } else {
        // Movimento livre e suave
        y += velv;
    }
    
    // Depois do movimento completo
    var _velh = sign(velh);
    if (place_meeting(x, y, colisoes)) {
        if (place_meeting(x + sign(velh), y, colisoes)) {
            x += (velh + 3) * -sign(_velh);
        }
    }
}

enum states {
    idle,
    walk,
    fall,
    jump,
    dash
}

estado = states.idle;

state_machine = function () {
    sprite_index = sprites[estado];
    switch (estado) {
    	case 0:
            inputs();
            
            if (velh != 0) {
                estado = states.walk;
            }
            
            if (velv < 0 and !chao) {
                estado = states.jump;
            }
            
            if ((velv == 0 or velv > 0) and !chao) {
                estado = states.fall;
            }
            
            if (has_dash and dash and carga > 0) {
                play_sound(snd_dash);
                if (rglf == 0 && updw == 0) {
                    dire = (dir == 1) ? 0 : 180;
                } else {
                    dire = point_direction(0, 0, rglf, updw);
                }
                estado = states.dash;
                carga--;
            }
            
            movement();
        break;
        case 1:
            inputs();
            
            if (velh == 0) {
                estado = states.idle;
            }
            
            if (velv < 0 and !chao) {
                estado = states.jump;
            }
            
            if ((velv == 0 or velv > 0) and !chao) {
                estado = states.fall;
            }
            
            if (has_dash and dash and carga > 0) {
                play_sound(snd_dash);
                if (rglf == 0 && updw == 0) {
                    dire = (dir == 1) ? 0 : 180;
                } else {
                    dire = point_direction(0, 0, rglf, updw);
                }
                estado = states.dash;
                carga--;
            }
            
            // Criando poeira ao andar
            var _chance = random(99);
            if (_chance > 90) {
                for (var i = 0; i < irandom_range(2, 6); i++) {
                	var _x = random_range(x - sprite_width / 2, x + sprite_width / 2);
                    instance_create_layer(_x, y, "Colisores", obj_fx_smoke);
                }
            }
                        
            movement();
        break;
        case 2:
            inputs();
            
            if (velv == 0 and chao) {
                for (var i = 0; i < irandom_range(6, 12); i++) {
                	var _x = random_range(x - sprite_width, x + sprite_width);
                    var _fx = instance_create_layer(_x, y, "Colisores", obj_fx_smoke);
                    _fx.image_index = irandom(7);
                }
                squash(1.4, 0.6, 0.1);
                play_sound(snd_fall, 0.2);
                estado = states.idle;
            }
            
            if (has_dash and dash and carga > 0) {
                play_sound(snd_dash);
                if (rglf == 0 && updw == 0) {
                    dire = (dir == 1) ? 0 : 180;
                } else {
                    dire = point_direction(0, 0, rglf, updw);
                }
                estado = states.dash;
                carga--;
            }
             
            movement();
        break;
        case 3:
            inputs();
            
            if ((velv == 0 or velv > 0) and !chao) {
                estado = states.fall;
            }
            
            if (chao) {
                estado = states.idle;
            }
            
            if (has_dash and dash and carga > 0) {
                play_sound(snd_dash);
                if (rglf == 0 && updw == 0) {
                    dire = (dir == 1) ? 0 : 180;
                } else {
                    dire = point_direction(0, 0, rglf, updw);
                }
                estado = states.dash;
                carga--;
            }
            
            movement();
        break;
        case 4: 
            inputs();
            
            // Cancelando Dash pra dar o double jump
            if (double_jump and jump and pulo > 0) {
                velv = -jspd;
                pulo--;
                play_sound(snd_jump, 0.4);
                
                // Cancelar dash
                t_dash = dash_t;
                estado = states.jump;
                
                for (var i = 0; i < irandom_range(6, 12); i++) {
                	var _x = random_range(x - sprite_width, x + sprite_width);
                    var _fx = instance_create_layer(_x, y, "Colisores", obj_fx_smoke);
                    _fx.image_index = irandom(7);
                }
                
                squash(0.8, 1.2);
                break;
            }
            
            t_dash--;
            
            velh = lengthdir_x(leng, dire);
            velv = lengthdir_y(leng, dire);
            
            // Efeito no player
            if (dire == 90 or dire == 270) {
                squash(.7, 1.3);
            } else {
                squash(1.3, .7);
            }
            
            // Criando o Rastro
            var _fx = instance_create_layer(x, y - random_range(2, 10), "Colisores", obj_fx_trail);
             
            if (t_dash <= 0) {
                estado = states.walk;
                t_dash = dash_t;
                
                // Diminuindo a velocidade
                velh = (mspd * sign(velh) * .5);
                velv = (jspd * sign(velv) * .5);
            }
        break;
    }
    
    // Cai do mundo
    if (y - sprite_height >= room_height) {
        global.mundo = false;
        room_restart();
    }
}

tp = noone;
device = function () {
    if (instance_exists(obj_teleport)) return;
        
    if (keyboard_check_pressed(vk_shift) or keyboard_check_pressed(ord("L"))) {
        if (instance_exists(obj_device)) {
            with (obj_device) {
            	if (cargas != 0) {
                    cargas--;
                    instance_create_layer(other.x, other.y - (sprite_get_height(spr_player_idle) / 2), "HUD", obj_teleport, {start: false});
                }
            }
        }
    }
}

coyote_buffer_jump = function () {
    // Coyote Jump
    if (chao) {
        coyo_tt = coyo_t;
    } else if (coyo_tt > 0) {
        coyo_tt--;
    }
    
    // Buffer Pulo
    if (jump) {
        buff_tt = buff_t;
    }
    
    if (buff_tt > 0) {
        buff_tt--;
    }
    
    if (buff_tt > 0 && (chao || coyo_tt > 0)) {
        play_sound(snd_jump, 0.4);
        velv = -jspd;
        buff_tt = 0;
        coyo_tt = 0;
        for (var i = 0; i < irandom_range(6, 12); i++) {
            var _x = random_range(x - sprite_width, x + sprite_width);
            var _fx = instance_create_layer(_x, y, "Colisores", obj_fx_smoke);
            _fx.image_index = irandom(7);
        }
        squash(0.8, 1.2);
    }
    
    // Double Jump
    if (!chao && coyo_tt <= 0 && double_jump && jump && pulo > 0) {
        play_sound(snd_jump, 0.4);
        velv = -jspd;
        pulo--;
        for (var i = 0; i < irandom_range(6, 12); i++) {
            var _x = random_range(x - sprite_width, x + sprite_width);
            var _fx = instance_create_layer(_x, y, "Colisores", obj_fx_smoke);
            _fx.image_index = irandom(7);
        }
        squash(0.8, 1.2);
    }
}

squash();
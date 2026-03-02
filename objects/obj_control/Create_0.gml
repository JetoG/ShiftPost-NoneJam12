// Colocando Efeito no Texto
font_enable_effects(fnt_game, true, {
    outlineEnable: true,
    outlineColor: c_black,
    outlineDistance: 3
});

save = false;

level = CheckActualLevel();
if (level > 0) {
    menu = ["Continuar", "Iniciar"];
} else {
    menu = ["Iniciar"];
}

opt     = 0;
opt_p   = 0;

controla_menu = function () {
    opt_p = opt;
    // --- TECLADO ---
    var _up = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up);
    var _down = keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down);
     
    // --- CONFIRMAR ---
    var _enter = keyboard_check_pressed(vk_enter);
     
    if ((_up) and opt > 0) {
        opt--;
        play_sound(snd_menu);
    } else if ((_down) and opt < array_length(menu) - 1) {
        opt++;
        play_sound(snd_menu);
    }
     
    if (_enter) {
        escolhe_menu();
        play_sound(snd_menu);
    }
}

function escolhe_menu () {
    var _sel = menu[opt];
    switch (_sel) {
    	case "Continuar":
            opt   = 0;
            r_opt = 0;
            level = CheckActualLevel();
            switch (level) {
            	case 1:
                    Transition(rm_fase_2);
                break;
                case 2:
                    Transition(rm_fase_3);
                break;
                case 3:
                    Transition(rm_fase_4);
                break;
                case 4:
                    Transition(rm_fase_5);
                break;
                case 5:
                    Transition(rm_fase_6);
                break;
                case 6:
                    Transition(rm_fase_7);
                break;
                case 7:
                    Transition(rm_fase_8);
                break;
                case 8:
                    Transition(rm_fase_9);
                break;
                case 9:
                    Transition(rm_fase_10);
                break;
            }
        break;
        case "Iniciar":
            opt   = 0;
            r_opt = 0;
            Transition(rm_fase_1);
            DeleteGame();
        break;
    }
}


// array que guarda a escala de cada item
menu_scale = array_create(array_length(menu), 0.5);
menu_angle = array_create(array_length(menu), 0);
logo_scale = 0.5;
draw_menu = function () {
    draw_set_font(fnt_game);
    text_align(1, 1);
    
    var _x   = display_get_gui_width() / 2;
    var _y   = display_get_gui_height() / 3;
    
    // Efeito
    var _t   = current_time * 0.002;
    var _imx = 1 + sin(_t) * 0.08;
    var _imy = 1 + sin(_t + 1.3) * 0.05;
    var _flt = sin(_t * 1) * 6;
    var _rct = Elastic("logo_react", 0, (opt != opt_p) ? 2 : 0, 1.5, 0.3);
    var _bst = 4 + _rct * 0.2;

    logo_scale = Elastic("logo", logo_scale, 6, 1.2, 0.25);
    
    // Desenhando a Logo
    draw_sprite_ext(spr_logo, 0, _x, _y + _flt, logo_scale, logo_scale, 0, c_white, 1);
    
    _y = display_get_gui_height() / 1.6;
    for (var i = 0; i < array_length(menu); i++) {
        var _tgt_s = (i == opt) ? 1.5 : 1.2;
        menu_scale[i] = Elastic(string("mscl_{0}", i), menu_scale[i], _tgt_s, .9, 0.25);
        
        var _sel = (i == opt && i != opt_p);
        menu_angle[i] = Elastic(string("mang_{0}", i), menu_angle[i], 0, .9, .2);
         
        // Cor do Texto
        var _cor = c_white;
        if (i == opt) {
            _cor = make_color_rgb(255, 213, 65);
        }
        
        // Texto
        var _texto = menu[i];
        var _alt   = string_height(_texto);
        var _pop = (i == opt) ? sin(_t * 2) * 2 : 0;
        
        draw_set_colour(_cor);
        draw_text_transformed(_x, _y + (i * _alt) * 2 + _pop, _texto, menu_scale[i], menu_scale[i], menu_angle[i]);
        draw_set_colour(-1)
    }
    
    draw_sprite_ext(spr_esc, 0, 33, display_get_gui_height() - 40, 3, 3, 0, c_white, 1);
    draw_text_transformed(120, display_get_gui_height() - 35, "Sair", 1, 1, 0);
    
    draw_set_colour(-1);
    text_align(-1, -1);
    draw_set_font(-1);
}

#region PAUSE

m_restart = ["Continuar", "Sair"];
r_opt     = 0;
pr_opt    = r_opt;

controla_m_restart = function () {
    pr_opt = r_opt;
    // --- TECLADO ---
    var _up = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up);
    var _down = keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down);
     
    // --- CONFIRMAR ---
    var _enter = keyboard_check_pressed(vk_enter);
     
    if ((_up) and r_opt > 0) {
        r_opt--;
        play_sound(snd_menu);
    } else if ((_down) and r_opt < 1) {
        r_opt++;
        play_sound(snd_menu);
    }
     
    if (_enter) {
        escolhe_m_restart();
        play_sound(snd_menu);
    }
}

function escolhe_m_restart () {
    switch (r_opt) {
        // Continuar
    	case 0:
            opt   = 0;
            r_opt = 0;
            global.pause = false;
        break;
        // Menu
        case 1:
            opt   = 0;
            r_opt = 0;
            Transition(rm_menu);
            level = CheckActualLevel();
            if (level > 0) {
                menu = ["Continuar", "Iniciar"];
            } else {
                menu = ["Iniciar"];
            }
            menu_scale = array_create(array_length(menu), 0.5);
            menu_angle = array_create(array_length(menu), 0);
        break;
    }
}

m_restart_scale = array_create(array_length(m_restart), 0.5);
m_restart_angle = array_create(array_length(m_restart), 0);

function draw_m_restart () {
    draw_set_font(fnt_game);
    text_align(1, 1);
    
    var _x   = display_get_gui_width() / 2;
    var _y   = display_get_gui_height() / 2;
    
    // Efeito
    var _t   = current_time * 0.002;
    var _imx = 1 + sin(_t) * 0.08;
    var _imy = 1 + sin(_t + 1.3) * 0.05;
    var _flt = sin(_t * 0.8) * 6;
    var _rot = sin(_t * 0.6) * 1.5;
    
    for (var i = 0; i < array_length(m_restart); i++) {
        var _tgt_s = (i == opt) ? 1.5 : 1.2;
        m_restart_scale[i] = Elastic(string("mrscl_{0}", i), m_restart_scale[i], _tgt_s, .9, 0.25);
        
        var _sel = (i == r_opt && i != pr_opt);
        m_restart_angle[i] = Elastic(string("mrang_{0}", i), m_restart_angle[i], 0, .9, .2);
        
        if (_sel) {
            var _dir = (i mod 2 == 0) ? 1 : -1;
            m_restart_angle[i] = 15 * _dir;
        }
        
        // Cor do Texto
        var _cor = c_white;
        if (i == r_opt) {
            _cor = make_color_rgb(255, 213, 65);
        }
        
        // Texto
        var _texto = m_restart[i];
        var _alt   = string_height(_texto);
        var _pop = (i == r_opt) ? sin(_t * 2) * 2 : 0;
        
        draw_set_colour(_cor);
        draw_text_transformed(_x, _y + (i * _alt) * 2 + _pop, _texto, m_restart_scale[i], m_restart_scale[i], m_restart_angle[i]);
        draw_set_colour(-1)
    }
    
    draw_set_colour(-1);
    text_align(-1, -1);
    draw_set_font(-1);
}

#endregion

draw_thanks = function () {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _draw  = round(_gui_w / room_width);
    
    draw_set_font(fnt_game);
    text_align(1, 1);
    
    var _x = (_gui_w / 2);
    var _y = (_gui_h / 3);
    
    
    draw_set_colour(c_orange);
    draw_text_transformed(_x, _y, "OBRIGADO POR JOGAR!", 2, 2, 0);
    
    _x = (_gui_w / 2);
    _y = (_gui_h / 2.3);
    var _scl = 1;
    draw_text_transformed(_x, _y, "Feito por: @JetoDev (YT)", _scl, _scl, 0);
     
    _y = round(_gui_h * 0.55);
    draw_sprite_ext(spr_esc, 0, _x, _y, _draw, _draw, 0, c_white, 1);
    
    text_align(-1, -1);
    draw_set_font(-1);
}

Transition = function (room=rm_menu) {
    if (room == rm_menu or room == rm_fase_1) {
        instance_create_layer(room_width / 2, room_height / 2, "Transicao", obj_teleport, {menu: true, room_tg: room});
    } else {
        instance_create_layer(room_width / 2, room_height / 2, "HUD", obj_teleport, {menu: true, room_tg: room});
    }
}

ClearFase = function () { 
    if (room == rm_fase_10) { 
        show_debug_message("EasterEgg! Acabou");
    } else { 
        Transition(room_next(room));
        if (room == rm_fase_1) {
            global.fases[0] = true;
        } else {
            if (!save) { 
                level = CheckActualLevel(); 
                if (level != noone) {
                    global.fases[level] = true;
                } 
                save = true;
            }
        }
    SaveGame();
   }
}
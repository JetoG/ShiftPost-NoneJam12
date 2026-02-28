// -- Variáveis --
#macro gm_speed global._gm_speed
#macro gm_debug true
// -- Modos --
#macro Normal:gm_debug 0
#macro Debug:gm_debug 1

global.mundo = false;

#region ScreenShake

// Variável Global do Shake
global.shake = 0;

/// @desc  Chame no objeto ou ação que você quer que faça o screenshake passando um valor.
/// @param {real} intensidade Intensidade do Tremor
function screenshake(intensidade) {
    // Se o valor passado for maior que o tremor existente
    // Ele aplica a nova intensidade
    if (intensidade > global.shake) {
        global.shake = intensidade;
    }
};

/// @description Este é o que vai atualizar o tremor o tempo todo.
/// @description Ele está dentro do obj_gcontrol (controlador do jogo) por padrão.
function upd_screenshake() {
    if (global.shake > 0.1) {
        // Aplica o deslocamento na câmera
        view_set_xport(view_current, random_range(-global.shake, global.shake));
        view_set_yport(view_current, random_range(-global.shake, global.shake));
    } else {
        // Quando o tremor se aproxima de 0
        // É finalizado o shake e ajustado a view.
        global.shake = 0;
        view_set_xport(view_current, 0);
        view_set_yport(view_current, 0);
    }
    // Normaliza a camera com lerp até chegar a 0
    global.shake = lerp(global.shake, 0, 0.1);
};

#endregion

#region Stretch and Squash

/// @desc Ativa um squash/stretch
/// @param {real} _xsc Escala Horizontal
/// @param {real} _ysc Escala Vertical
/// @param {real} _spd Velocidade para voltar ao valor Padrão
function squash(_xsc=1, _ysc=1, _spd=0.1) {
    xscale = _xsc;
    yscale = _ysc;
    sscale = _spd;
}

/// @desc Atualiza squash/stretch (Step do Objeto)
function step_squash() {
    xscale = lerp(xscale, 1, sscale);
    yscale = lerp(yscale, 1, sscale);
}

/// @desc Desenha com squash/stretch aplicado
/// @desc Fique de olho, para cada projeto aqui pode ser alterado.
function draw_squash(_spr=sprite_index, _img=image_index, _imgx=image_xscale, _imgy=image_yscale, _x=x, _y=y, _angle=image_angle, _blend=image_blend, _alpha=image_alpha) {
    draw_sprite_ext(_spr, _img, _x, _y, xscale * _imgx, yscale * _imgy, _angle, _blend, _alpha);
}

#endregion

/// @desc Aproxima um valor parecido com o Lerp
/// @param {Real} _v1 Real
/// @param {Real} _v2 Real
/// @param {Real} _amt Quantidade
function approach (_v1, _v2, _amt) {
    if (_v1 < _v2) {
        _v1 += _amt;
        if (_v1 > _v2) {
            return _v2;
        }
    } else {
        _v1 -= _amt;
        if (_v1 < _v2) {
            return _v2;
        }
    }
    return _v1;
}

fases[9] = false;
pause    = false;

function SaveGame () {
    if (file_exists("save.sav")) {
        file_delete("save.sav");
    }
    ini_open("save.sav");
        ini_write_string("Fases", "levels", json_stringify(global.fases)); 
    ini_close();
}
	
function LoadGame () {
    if (file_exists("save.sav")) {
        ini_open("save.sav");
            var _string_carregada = ini_read_string("Fases", "levels", "");
            if (_string_carregada != "") {
                global.fases = json_parse(_string_carregada);
            }
        ini_close();
    }
}

function DeleteGame () {
    if (file_exists("save.sav")) {
        file_delete("save.sav");
    }
    global.fases = array_create(10, 0);
}

function CheckActualLevel () {
    var _level = noone;
    for (var i = 0; i < array_length(global.fases); i++) {
    	if (global.fases[i] == 0) {
        	_level = i;
            break;
        }
    }
    return _level;
}

LoadGame();
// -- Variáveis --
#macro gm_speed global._gm_speed
#macro gm_debug true
// -- Modos --
#macro Normal:gm_debug 0
#macro Debug:gm_debug 1

global.mundo = false;
global.pause = false;

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

/**
 * Function Description
 * @param {asset.gmsound} _sound Toca um som. Podendo escolher volume e o pitch
 * @param {real} [_gain]=1 Volume
 * @param {real} [_amt]=0.1 Pitch
 */
function play_sound (_sound, _gain=1, _amt=0.1) {
    audio_stop_sound(_sound)
    var _pit = random_range(1 - _amt, 1 + _amt);
    audio_play_sound(_sound, 0, false, _gain, , _pit);
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

/// @desc Alinhar textos
/// @param {real} [_h]=-1 Horizontal
/// @param {real} [_v]=-1 Vertical
function text_align (_h=-1, _v=-1) {
    draw_set_halign(_h);
    draw_set_valign(_v);
}


/// @desc Aplica um efeito de movimento elástico baseado em Lerp, mantendo uma variável interna persistente por instância. 
/// Permite que o valor acelere em direção ao alvo com o uma mola.
/// A função cria automaticamente uma variável intera única (por instância) com o nome fornecido, 
/// permitindo aplicar múltiplos efeitos elásticos no memos objeto sem conflito.
/// @param  {string} _nam Nome base da variável interna que será criada. Deve ser único para cada propriedade que usar o efeito.
/// @param  {any}    _val Valor atual que será suavizado pelo efeito.
/// @param  {any}    _tar Valor alvo que o movimento tenta alcançar.
/// @param  {real}   _for Intensidade da Força Elástica. Valores maiores aumentam o "puxão" inicial.
/// @param  {real}   _amt Suavização do movimento (0 a 1). Controla o quanto o valor interno se aproxima do objetivo a cada step.
/// @param  {real}   _ini Valor inicial da variável interna. Normalmente deixe 0.
/// @return {real}   Retorna o valor suavizado (_val + deslocamento_elástico).
function Elastic (_nam, _val, _tar, _for=1, _amt=.25, _ini=0) {
    // ID do Objeto
    var _id  = id;
    // Variável Única
    var _var = "spring_" + string("{0}_{1}", _nam, _id);
    
    // Verifica se a Variável não existe
    if (!variable_instance_exists(_id, _var)) {
        // Cria a variável
        variable_instance_set(_id, _var, _ini);
    }
    
    // Pegando a variável criada e aplicando o efeito
    var _els = variable_instance_get(_id, _var);
    _els = lerp(_els, (_tar - _val) * _for, _amt);
     
    // Atualizando a variável criada
    variable_instance_set(_id, _var, _els);
     
    return _val + _els;
}

LoadGame();
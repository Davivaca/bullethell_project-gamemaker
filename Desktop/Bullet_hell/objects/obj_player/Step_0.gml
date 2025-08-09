// Fazendo ele mudar o sprite quando anda
// Verificar se está se movendo
var movendo = abs(velh) > 0.1 || abs(velv) > 0.1;

// Trocar sprite com base no movimento
if (movendo) {
    sprite_index = spr_player_run;
} else {
    sprite_index = spr_player_idle;
}



// Arrumando a minha profundidade
depth = -bbox_bottom;

// DEFININDO OS CONTROLES DE MOVIMENTAÇÃO
var up, down, left, right;
if (global.usar_wasd) {
    up = keyboard_check(ord("W"));
    left = keyboard_check(ord("A"));
    down = keyboard_check(ord("S"));
    right = keyboard_check(ord("D"));
} else {
    up = keyboard_check(vk_up);
    left = keyboard_check(vk_left);
    down = keyboard_check(vk_down);
    right = keyboard_check(vk_right);
}
// Checa e zera velocidade ao trocar controles
// Zera velocidade SE o controle tiver acabado de mudar
if (!variable_global_exists("controle_anterior")) {
    global.controle_anterior = global.usar_wasd;
}

if (global.usar_wasd != global.controle_anterior) {
    var nenhum_input = (up + down + left + right == 0);

    if (nenhum_input) {
        vel = 0;
        velh = 0;
        velv = 0;
    }

    global.controle_anterior = global.usar_wasd;
}



//velh = (right - left) * max_vel; Código não é mais necessário

//velv = (down - up) * max_vel;	Código não é mais necessário

// show_debug_message(arma); // Não preciso mais desse debug

// Ajustar o movimento
//Checando se o usuário está apertando alguma coisa
// XOR ou exclusivo
// XOR = ^^
/*
if(up xor down or left ^^ right){
	// Descobrir para que direção estou me movendo
	move_dir = point_direction(0, 0, (right-left), (down-up));
	//Ganhar velocidade quando ele começa a se mover
	vel = max_vel;
}else{
	vel = lerp(vel, 0, 0.1);
}
*/
// NOVO CÓDIGO SUBSTITUIDO
// COLISÃO NA VERTICAL
var input_x = right - left;
var input_y = down - up;

// Corrige problema de entrada residual ao trocar tipo de controle
if (input_x == 0 && input_y == 0) {
    vel = lerp(vel, 0, 0.2); // desacelera
} else {
    // Atualiza direção
    move_dir = point_direction(0, 0, input_x, input_y);

    // Corrige aceleração acumulada (normaliza input)
    var magnitude = sqrt(input_x * input_x + input_y * input_y);
    if (magnitude > 0) {
        vel += 0.6;
    }
}

vel = clamp(vel, 0, max_vel);

velh = lengthdir_x(vel, move_dir);
velv = lengthdir_y(vel, move_dir);


// Direção de movimento real horizontal (importante!)
var dir_h_real = sign(lengthdir_x(1, move_dir)); // -1, 0, 1

// Se arma_cooldown ativo, reduz a contagem
if (arma_cooldown > 0) {
    arma_cooldown -= 1;
}

usa_arma();
joga_arma();
efeito_dano();
olha_mouse();
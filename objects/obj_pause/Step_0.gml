function is_game_active() {
    return !global.pause && !global.player_dead;
}

tempo++;

// Apenas uma vez o toggle de pausa
if (!global.player_dead && keyboard_check_pressed(vk_escape)) {
    global.pause = !global.pause;

    if (global.pause) {
        game_set_speed(0, gamespeed_fps); // pausa total
    } else {
        game_set_speed(60, gamespeed_fps); // volta ao normal (ajuste esse valor se sua room_speed for diferente)
    }

    selected_option = 0;
    just_paused = true;
} else {
    just_paused = false;
}

// GAME OVER
if (global.vida_player <= 0 && !global.player_dead)
{
	global.arma_atual = noone;
    global.player_dead = true;
    global.pause = false; // despausa se estiver pausado
    game_set_speed(60, gamespeed_fps); // volta à velocidade normal
}

if (global.player_dead && keyboard_check_pressed(vk_enter)) {
    game_restart(); 
}

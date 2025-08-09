
if (!variable_global_exists("usar_wasd")) {
    global.usar_wasd = true; // ou false, valor padrão
}

if (!variable_global_exists("tela_cheia")) {
    global.tela_cheia = false; // começa em modo janela
}
window_set_fullscreen(global.tela_cheia);

room_speed = 60;
// window_set_fullscreen(true); // Colocar isso se quiser tela cheia

opcoes = ["New Game","Continue", "Options", "Exit Game"];
index = 0;
op_max = array_length(opcoes);
no_menu_opcoes = false;
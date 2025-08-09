draw_set_font(ft_menu);


var margin = 50;
var gui_largura = display_get_gui_width();
var gui_altura = display_get_gui_height();
var x1 = gui_largura/2;
var y1 = gui_altura/2;

var m_x = device_mouse_x_to_gui(0); // Pegando a posição do meu mouse em relação a tela
var m_y = device_mouse_y_to_gui(0);

if (!no_menu_opcoes) {
	// MENU PRINCIPAL
	for (var i = 0; i < op_max; i++) {
		var y2 = y1 + (margin * i);
		var string_w = string_width(opcoes[i]);
		var string_h = string_height(opcoes[i]);
		
		if (point_in_rectangle(m_x, m_y, x1 - string_w / 2, y2 - string_h / 2, x1 + string_w / 2, y2 + string_h / 2)) {
			draw_set_color(c_yellow);
			index = i;
			
			if (mouse_check_button_pressed(mb_left)) {
				if (index == 0) room_goto_next();
				else if (index == 2) no_menu_opcoes = true;
				else if (index == 3) game_end();
			}
		} else {
			draw_set_color(c_white);
		}
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_text(x1, y2, opcoes[i]);
	}
} else {
	// SUBMENU OPTIONS
	var op_wasd = global.usar_wasd ? "Control: WASD" : "Control: Arrow keys";


	var op_tela = global.tela_cheia ? "Screen: Fullscreen" : "Screen: Window";

	var op_voltar = "Back";

	var opcoes_opt = [op_wasd, op_tela, op_voltar];

	for (var j = 0; j < 3; j++) {
		var y_opt = y1 + margin * j;
		var str_w = string_width(opcoes_opt[j]);
		var str_h = string_height(opcoes_opt[j]);

		if (point_in_rectangle(m_x, m_y, x1 - str_w / 2, y_opt - str_h / 2, x1 + str_w / 2, y_opt + str_h / 2)) {
			draw_set_color(c_yellow);
			
			if (mouse_check_button_pressed(mb_left)) {
			if (j == 0) global.usar_wasd = !global.usar_wasd; // Alterna controle

				else if (j == 1) {
					global.tela_cheia = !global.tela_cheia;
					window_set_fullscreen(global.tela_cheia);

					room_speed = 60; // Ajusta FPS fixo após mudar fullscreen
				}
				else if (j == 2) 
				{
					no_menu_opcoes = false // Voltar
					
				}
			}
		} else {
			draw_set_color(c_white);
		}

		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_text(x1, y_opt, opcoes_opt[j]);
	}
}

draw_set_font(-1);
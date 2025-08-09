var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Código anttigo
/*
if (global.pause && !just_paused)
{
	// Posso desenhar a interface de pause
	draw_set_alpha(.7);
	draw_set_color(c_black);
	draw_rectangle(0,0,gui_w,gui_h,false);
	// Resetando os draws
	draw_set_alpha(1);
	draw_set_color(c_white);
	// Desenhando o JOGO PAUSADO
	draw_set_font(ft_menu);
	draw_set_valign(fa_center);
	draw_set_halign(fa_center);
	draw_text(gui_w /2, gui_h / 2, "GAME PAUSED");
	// Resetando os draws
	draw_set_valign(-1);
	draw_set_halign(-1);
	
}
draw_set_font(-1);
*/
if (global.player_dead) {
    // Tela totalmente preta
    draw_set_alpha(1); // opacidade total
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);

    // Texto de Game Over
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_set_font(ft_menu); // sua fonte personalizada

    draw_text(gui_w / 2, gui_h / 2, "GAME OVER\nPress Enter to restart");

    return; // Impede que o menu de pause seja desenhado
}

if (global.pause && !just_paused)
{
	draw_set_font(ft_menu);
	// Posso desenhar a interface de pause
	draw_set_alpha(.7);
	draw_set_color(c_black);
	draw_rectangle(0,0,gui_w,gui_h,false);
	// Resetando os draws
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_set_font(fnt_municao_grande);

draw_set_font(ft_menu);


var margin = 50;
var gui_largura = display_get_gui_width();
var gui_altura = display_get_gui_height();
var x1 = gui_largura/2;
var y1 = gui_altura/2;

var m_x = device_mouse_x_to_gui(0); // Pegando a posição do meu mouse em relação a tela
var m_y = device_mouse_y_to_gui(0);

for(var i = 0; i < op_max ; i++){
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	var y2 = y1 + (margin * i);
	
	var string_w = string_width(opcoes_pause[i]); // Cria uma caixa que vai ter o valor da extensão do texto
	var string_h = string_height(opcoes_pause[i]);
	
	if(point_in_rectangle(m_x, m_y, x1 - string_w / 2, y2 - string_h / 2, x1 + string_w / 2, y2 + string_h / 2))
	{
		draw_set_color(c_yellow);
		index = i;
		if(mouse_check_button_pressed(mb_left))
		{
			if(index ==0)
			{
				global.pause = false;
				just_paused = true;

			}else if(index ==2){
				game_end();
			}else if(index==1)
			{
				room_goto(Room_menu);
			}
		}
	}else
	{
		draw_set_color(c_white);
	}
	draw_text(x1,y1 + (margin * i),opcoes_pause[i]);
}
draw_set_font(-1);
 }
draw_set_font(-1);
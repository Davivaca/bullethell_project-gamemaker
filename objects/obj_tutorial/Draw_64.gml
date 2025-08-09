// --- EVENTO DRAW GUI ---

if (show_dialog) {	// Só desenha se o diálogo estiver ativo
	global.dialogue_active = true; // Ativa o dialogo
	
    var who = dialog[dialog_index][0];    // Pega quem está falando: "tutorial" ou "player"

    var box_height = 200;                  // Altura da caixa de diálogo
    var margin = 32;                       // Margem lateral da caixa

    var box_x1 = margin;                   // Posição X inicial da caixa (esquerda)
    var box_x2 = display_get_gui_width() - margin;  // Posição X final da caixa (direita)

    var box_y2 = display_get_gui_height() - 10;    // Posição Y final da caixa (base da tela - 10)
    var box_y1 = box_y2 - box_height;               // Posição Y inicial da caixa (topo da caixa)

    // Desenha borda branca da caixa (um pouco maior para contorno)
    draw_set_color(c_white);
    draw_rectangle(box_x1 - 2, box_y1 - 2, box_x2 + 2, box_y2 + 2, false);

    // Desenha fundo preto da caixa
    draw_set_color(c_black);
    draw_rectangle(box_x1, box_y1, box_x2, box_y2, false);

    // Define posição onde o rosto do personagem será desenhado
    var face_x = box_x1 + 16;
    var face_y = box_y1 + 8;

    // Desenha o rosto do personagem com base no quem está falando
    if (who == "tutorial") {
        draw_sprite_ext(spr_face_tutorial, 0, face_x, face_y, 2, 2, 0, c_white, 1);
    } else if (who == "player") {
        draw_sprite_ext(spr_face_player, 0, face_x, face_y, 2, 2, 0, c_white, 1);
    }

    // Configura cor e fonte para o texto do diálogo
    draw_set_color(c_white);
    draw_set_font(ft_menu);

    // Posição do texto (logo após a imagem do rosto)
    var text_x = box_x1 + 250;
    var text_y = box_y1 + 50;  // Inicia um pouco mais abaixo para ajustar o texto dentro da caixa
    var text_width = box_x2 - text_x - 16; // Largura disponível para o texto (considerando margens)

	if(dialog_index == 0)
	{
		// Desenha o texto com ajuste para quebra de linha (utilizando o "text_width" para limitar)
		draw_text_ext(text_x + 200, text_y, typed_text, -1, text_width);
	}else if (dialog_index == 1)
	{
		// Desenha o texto com ajuste para quebra de linha (utilizando o "text_width" para limitar)
		draw_text_ext(text_x, text_y, typed_text, -1, text_width);
	}else if (dialog_index == 2)
	{
		// Desenha o texto com ajuste para quebra de linha (utilizando o "text_width" para limitar)
		draw_text_ext(text_x + 250, text_y, typed_text, -1, text_width);
	}else if (dialog_index == 3)
	{
		// Desenha o texto com ajuste para quebra de linha (utilizando o "text_width" para limitar)
		draw_text_ext(text_x + 450, text_y + 25, typed_text, -1, text_width);
	}else
	{
		// Desenha o texto com ajuste para quebra de linha (utilizando o "text_width" para limitar)
		draw_text_ext(text_x + 100, text_y, typed_text, -1, text_width);
	}
}
	global.dialogue_active = false; // Desativa o dialogo
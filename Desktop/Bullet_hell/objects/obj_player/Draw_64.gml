if (global.player_dead) {
    return; // Para de desenhar qualquer coisa se o jogador estiver morto
}
if (global.pause) {
    return; // Para de desenhar qualquer coisa se o jogo pausar
}


// Mostrando quanto de vida que o player tem
for(var i=0; i < global.vida_total_player; i++){
	if( i >= vida && vida < global.vida_total_player)
	{
		draw_sprite_ext(spr_life_empty, 0, 20 * (i * 3.4), 8, 1, 1, 0, c_white, 1);
	}else
	{
		draw_sprite_ext(spr_life, 0, 20 * (i * 3.4), 8, 1, 1, 0, c_white, 1);
	}
}

// Desenhando quanto dinheiros o player tem
draw_text(20, 50, global.dinheiro);

// Coisa da arma
// Mostrando arma e munição atual
if (global.arma_atual != noone && obj_player.arma == global.arma_atual) {
    var arma = global.arma_atual;

    var margem = 20;
    var escala = 3; // ← Escala da sprite
    var y_offset_extra = 40; // ← Empurra a imagem mais pra baixo

    var sprite_largura = sprite_get_width(arma.sprite_index) * escala;
    var sprite_altura = sprite_get_height(arma.sprite_index) * escala;

    var x_pos = display_get_gui_width() - sprite_largura - margem;
    var y_pos = margem + y_offset_extra;

    // Desenha a sprite da arma 3x maior
    draw_sprite_ext(
        arma.sprite_index, 0,
        x_pos, y_pos,
        escala, escala,
        0,
        c_white,
        1
    );

    // Desenhar o texto grande (recomenda-se usar uma fonte personalizada!)
    // Exemplo de fonte customizada maior: fnt_municao_grande
    var fonte_antiga = draw_get_font();
    if (font_exists(fnt_municao_grande)) {
        draw_set_font(fnt_municao_grande);
    }

    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    draw_text(x_pos - 10, y_pos + sprite_altura / 2, string(arma.tiros_atuais) + " / " + string(arma.balas_maximas));

    // Restaura fonte original
    draw_set_font(fonte_antiga);
}
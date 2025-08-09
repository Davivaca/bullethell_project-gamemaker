event_inherited();
vida_max = 4;
vida_atual = vida_max;

estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

tempo_dano = room_speed / 4;
timer_dano = tempo_dano;

sat = 0;

destino_x = x;
destino_y = y;
velh = 0;
velv = 0;

tempo_morte = room_speed;

alvo = noone;
alvo_dir = 0;

sprite = sprite_index;
xscale = 1;
yscale = 1;

vel = 0.7;

larg_visao = 200; // alcance de visão

dano_timer = 0;
tempo_dano = room_speed / 8;
atirando = false;
tempo_entre_tiros = room_speed;
timer_tiro = 0;

mover = function(_dir, _spd) {
    velh = lengthdir_x(_spd, _dir);
    velv = lengthdir_y(_spd, _dir);
}


campo_visao_circular = function(_raio)
{
	if (!instance_exists(obj_player)) return noone;

	// Se estiver fora do alcance, nem tenta
	if (point_distance(x, y, obj_player.x, obj_player.y) > _raio) return noone;

	// Se houver uma parede no meio, não enxerga
	if (collision_line(x, y, obj_player.x, obj_player.y, obj_block, false, true))
	{
		return noone;
	}

	// Se tudo ok, retorna o player
	return obj_player;
}


desenha_sprite = function()
{
	// SE eu estou levando dano eu mudo de cor
	if(dano)
	{
		shader_set(sh_branco);
		draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
		shader_reset();
	}else // Não estou levando dano eu me desenho normalmente
	{
		draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
	}
}

desenha_sombra = function()
{
	draw_sprite_ext(spr_sombra, 0, x, y + 30, .5, .3, 0, c_white, .25);
}

muda_estado = function(_estado)
{
	tempo_estado--;
	timer_estado = irandom(tempo_estado);
	
	if(timer_estado == tempo_estado or tempo_estado <= 0)
	{
		estado = _estado[irandom(array_length(_estado)-1)];
		tempo_estado = room_speed * 10;
	}
}
estado_parado = function()
{
	image_blend = c_white;// --------------------------------- MUDAR ISSO AQUI
	sprite_index = spr_mirtilo_iddle; // --------------------------------- MUDAR ISSO AQUI
	velh = 0;
	velv = 0;

	alvo = campo_visao_circular(larg_visao);
	if (alvo) estado = estado_atira;

	muda_estado([estado_passeando, estado_passeando]);
}

estado_passeando = function()
{
	image_blend = c_white;// --------------------------------- MUDAR ISSO AQUI
	sprite_index = spr_mirtilo_walk; // --------------------------------- MUDAR ISSO AQUI
	if (point_distance(x, y, destino_x, destino_y) < 100)
	{
		destino_x = random(room_width);
		destino_y = random(room_height);
	}
	var _dir = point_direction(x, y, destino_x, destino_y);
	mover(_dir, vel);


	xscale = sign(velh);

	alvo = campo_visao_circular(larg_visao);
	if (alvo) estado = estado_atira;

	muda_estado([estado_passeando, estado_parado]);
}
estado_dano = function()
{
	timer_dano--;
	velh = lengthdir_x(1, p_dir);
	velv = lengthdir_y(1, p_dir);

	if(timer_dano <= 0)
	{
		if(vida_atual <= 0)
		{
			estado = estado_morto;
		}
		else
		{
			estado = estado_parado;
			timer_dano = tempo_dano;
		}
	}
}

estado_morto = function()
{
	tempo_morte--;
	image_alpha -= .09;

	image_speed = 0;
	velh = 0;
	velv = 0;

	if(image_alpha <= 0) 
	{
		instance_destroy();
		dropa_loot(100, 1);
	}
}

leva_dano = function(_dano)
{
	if(estado != estado_morto)
	{
		estado = estado_dano;
		vida_atual -= (_dano == undefined) ? 1 : _dano;
		dano = true;
	}
}
estado_atira = function()
{
	
	image_blend = c_white; // Mudar isso depois
    sprite_index = spr_mirtilo_walk; // ou outro sprite de andar-atirando

// Verifica se o jogador ainda está visível (sem parede no meio)
if (!instance_exists(alvo) || collision_line(x, y, alvo.x, alvo.y, obj_block, false, true))
{
    alvo = noone;
    estado = estado_parado;
    return;
}
	// Direção e movimento em direção ao player
    var dir = point_direction(x, y, alvo.x, alvo.y);


    xscale = (alvo.x < x) ? -1 : 1;

    // Timer de tiro
    timer_tiro++;
    if (timer_tiro >= tempo_entre_tiros)
    {
		image_blend = c_red; // Mudar isso depois
        var inst = instance_create_layer(x, y, "Tiros", obj_tiro_inimigo);
        inst.direction = dir;
        inst.speed = 5;

        timer_tiro = 0;
    }

    // Sair do modo de ataque se o jogador estiver longe
    if (point_distance(x, y, alvo.x, alvo.y) > larg_visao * 1.5)
    {
        alvo = noone;
        estado = estado_parado;
    }
	mover(dir, vel);

}

sprite_index = sprite;

estado = estado_parado;

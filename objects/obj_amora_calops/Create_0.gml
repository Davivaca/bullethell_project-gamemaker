// CÓDIGOS SUBSTITUIDOS ENTRE 150 E 160 E 115 A 120 Função campo visão substituida

// Herdando as informações do meu pai
event_inherited();

vel_persegue = 2.5;   // velocidade ao perseguir


// Codigo muito doido
// Tamanho de cada célula do grid
grid_celula = 32;

// Criar o grid baseado no tamanho da room
grid = mp_grid_create(0, 0, room_width div grid_celula, room_height div grid_celula, grid_celula, grid_celula);

// Adiciona os blocos como obstáculos no grid
mp_grid_add_instances(grid, obj_block, false);

// Cria o path
path_inimigo = path_add();


// Ajustando a minha vida
vida_max = 3;
vida_atual = vida_max;

estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

tempo_dano = room_speed / 4;
timer_dano = tempo_dano;

// Saturação
sat = 0;


destino_x = x;
destino_y = y;
velh = 0;
velv = 0;

tempo_morte = room_speed;

alvo = noone;
alvo_dir = 0;
duracao_ataque = 0.8;
tempo_ataque = duracao_ataque;

// Tempo do dano
dano_timer = 0;
tempo_dano = room_speed / 8;

sprite = sprite_index;
xscale = 1;
yscale = 1;

vel = 1;
// Estado onde ele fica paradinho

// Estado onde ele passeia

// Estado onde ele persegue o player

// Método de mudança de estado
muda_estado = function(_estado)
{
	tempo_estado--;
	timer_estado = irandom(tempo_estado);
	
	if(timer_estado == tempo_estado or tempo_estado <= 0)
	{
		// Vou checar qual estado eu devo ir
		estado = _estado[irandom(array_length(_estado)-1)];
		
		tempo_estado = room_speed * 10;
	}
}

desenha_sprite = function()
{
	// SE eu estou levando dano eu mudo de cor
	if(dano)
	{
		shader_set(sh_branco);
		draw_sprite_ext(sprite, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
		shader_reset();
	}else // Não estou levando dano eu me desenho normalmente
	{
		draw_sprite_ext(sprite, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
	}
}

desenha_sombra = function()
{
	draw_sprite_ext(spr_sombra, 0, x, y, .7, 1.3, 0, c_white, .25);
}

///@method campo_de_visão(largura altura escalaX)
/*
campo_visao = function(_largura, _altura, _xscale)
{
	var _x1, _y1, _x2, _y2;
	_x1 = x;
	_y1 = y + _altura / 2 - sprite_height / 2;
	_x2 = _x1 + _largura * xscale;
	_y2 = _y1 - _altura;
	// Desenhando o meu quadrado
	//draw_rectangle(_x1, _y1, _x2, _y2, false);
	
	// Checando se o player está no meu campo de visão
	var _alvo = collision_rectangle(_x1, _y1, _x2, _y2, obj_player, 0, 1);
	
	return _alvo;
}
*/
campo_visao_circular = function(_raio)
{
	return (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) <= _raio) ? obj_player : noone;
}


// Método dele parado
estado_parado = function()
{
	// Definindo a sprite
	sprite = spr_amora_idle;
	image_blend = c_white;
	
	// Zerando a velocidade quando eu estiver parado
	velh = 0;
	velv = 0;
	
	//alvo = campo_visao(larg_visao, sprite_height * alt_visao, xscale);
	alvo = campo_visao_circular(larg_visao);

	// Se eu tenho um alvo eu sigo o alvo
	if (alvo)
	{
		estado = estado_persegue;
	}
		
	muda_estado([estado_passeando, estado_passeando]);
}

estado_passeando = function()
{
	image_blend = c_white;
	// Definindo a sprite
	sprite = spr_amora_run;
	
	// Fazer ele passear
	// Ele vai escolher um ponto qualquer dentro da room 
	// Checando a distancia do destino
	var _dist = point_distance(x, y, destino_x, destino_y);
	// Só vou definir um destino se eu estiver próximo do meu destino
	if(_dist < 100)
	{
		destino_x = random(room_width);
		destino_y = random(room_height);
	}
	// Achando a direção para o meu destino
	var _dir = point_direction(x, y, destino_x, destino_y);
	
	// Olhando para onde eu estou indo
	if (velh != 0)
	{
		xscale = sign(velh);
	}
	// Me movendo para o meu destino
	velh = lengthdir_x(vel, _dir);
	velv = lengthdir_y(vel, _dir);
	
	// Olhando para a frente
	// Código substituido
	//alvo = campo_visao(larg_visao, sprite_height * alt_visao, xscale);
	alvo = campo_visao_circular(larg_visao);

	if (alvo)
	{
		estado = estado_persegue;
	}
	
	muda_estado([estado_passeando, estado_parado]);
}

// Estado de perseguição
// Ele vai seguir o player
estado_persegue = function()
{
    sprite = spr_amora_run;

    if (instance_exists(alvo))
    {
        var _dist = point_distance(x, y, alvo.x, alvo.y);

        // Se o jogador estiver muito longe, desiste
        if (_dist > larg_visao * 2)
        {
            alvo = noone;
            muda_estado([estado_parado, estado_passeando]);
            exit;
        }

        // Se o jogador está muito perto, ataca
        if (_dist < larg_visao / 2)
        {
            estado = estado_prepara_ataque;
            exit;
        }

        // Recalcula o caminho até o jogador
		if (mp_grid_path(grid, path_inimigo, x, y, alvo.x, alvo.y, true))
		{
		    var dist = point_distance(x, y, alvo.x, alvo.y);
		    var vel_calc = clamp(lerp(vel, vel_persegue, 1 - dist / (larg_visao * 2)), vel, vel_persegue);
		    path_start(path_inimigo, vel_calc, path_action_stop, false); // Chamando apenas uma vez
		}
		else
		{
		    // Não consegue achar caminho — para ou tenta outro estado
		    velh = 0;
		    velv = 0;
		}

    }
    else
    {
        muda_estado([estado_parado, estado_passeando]);
    }
}



// Estado de preparação do ataque (Aviso ao jogador que alguma coisa vai acontecer)
estado_prepara_ataque = function()
{
	image_blend = c_red;
	// Variavel para controlar a minha cor
	
	
	// Sat nunca passa de 1
	if (sat < 1)
	{
		sat += (delta_time / 200000);
	}
	
	// Animação use a sat
	image_speed = sat;
	
	sprite = spr_amora_idle;
	velv = 0;
	velh = 0;
	image_blend = make_color_hsv(255, sat * 255, 255);
	
	// Se eu esperei 2 segundos então eu ataco o alvo
	if (sat > 1)
	{
		estado = estado_ataque;
		alvo_dir = point_direction(x, y, alvo.x, alvo.y);
		sat = 0;
		image_speed = 1;
	}
}
// Estado de ataque
// Estado de ataque
// Estado de ataque
estado_ataque = function()
{
    tempo_ataque -= delta_time / 1000000;
    
    // Movimentação mais suave, sem multiplicação agressiva
    velh = lengthdir_x(vel, alvo_dir);  // Remover *4, mantendo o movimento suave
    velv = lengthdir_y(vel, alvo_dir);
    
    // Fazendo ele sair do estado de ataque
    if(tempo_ataque <= 0)
    {
        // Mudando de estado
        estado = estado_parado;
        
        // Resetando o tempo de ataque
        tempo_ataque = duracao_ataque;
    }
}



estado_dano = function()
{
	timer_dano--;
	// Sendo empurrado para trás
	velh = lengthdir_x(1, p_dir);
	velv = lengthdir_y(1, p_dir);
	
	
	if(timer_dano <= 0)
	{
		// Checando SE eu devo morrer
		if(vida_atual <= 0)
		{
			estado = estado_morto;
		}else
		{
			estado = estado_parado;
		
			// Resetando o timer_dano
			timer_dano = tempo_dano;
		}
	}
}

estado_morto = function()
{
	// Diminuir o tempo de morte
	tempo_morte--;
	image_alpha -= .09;
	
	image_speed = 0;
	velh = 0;
	velv = 0;
	
	if(image_alpha <= 0) 
	{
		// DESTRUINDO VARIAVEIS QUE AJUDAM A DESVIAR
		mp_grid_destroy(grid);
		path_delete(path_inimigo);

		instance_destroy()
		// Dropando meu loot
		dropa_loot(100, 1);
	}
}

leva_dano = function(_dano)
{
	if(estado != estado_morto)
	{
		estado = estado_dano;
	
		// Perdendo vida
		// Se a pessoa não definiu o dano então eu perco 1 de vida
		if(_dano == undefined) vida_atual -= 1;
		// Caso contrario eu perco _dano de vida
		else vida_atual -= _dano;
	
		// Vou avisar que ele levou dano
		dano = true;
	}
}
// Onde ele vai atacar o player

// Definindo o estado inicial dele
estado = estado_parado;
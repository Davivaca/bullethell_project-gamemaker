global.player_dead = false;
global.vida_player = 3; // Reinicia a vida (se estiver usando isso como base)

// Iniciando variaveis

arma_cooldown = 0; // COOL DOWN DAS MINHAS ARMAS

velh = 0;
velv = 0;
max_vel = 5;
// Velocidade de forma geral
vel = 0;
// Direção de movimento
move_dir = 0;
arma = noone;

dano = false;
vida_max = 3;
vida = vida_max;

// 1 Segundo invencivel
tempo_inv = room_speed * 2;

visual_dir = 1; // 1 = direita, -1 = esquerda

// Método de olhar onde o jogador tá mirando
olha_mouse = function()
{
	// Checar se o x do mouse do jogador é maior ou igual ao meu x
	// Checando se o mouse_x - x é diferente de zero
	visual_dir = mouse_x - x != 0 ? sign(mouse_x - x) : 1;
}

efeito_dano = function()
{
	static _valor = -0.05;
	// SE eu tomei dano eu mudo a minha transparencia
	
	//Checando se eu tomei ou não o dano
	//SE eu não tomei o dano eu NÃO executo nada
	if(!dano) return;
	
	// SE eu sumir o valor fica positivo
	if(image_alpha <= 0) _valor *= -1;
	
	// SE eu estiver totalmente visível então o valor fica positivo
	if(image_alpha > 1) _valor *= -1;
	//Código com o efeito
	image_alpha += _valor;
}

toma_dano = function(){
	// Quando eu tomar dano eu perco 1 de vida SE eu ainda não tomei dano
	// SE a variável dano for false então eu tomo dano
	// SE eu estou tomando dano eu não executo o resto do código
	if (dano) return;
	
	// Perdendo vida
	vida--;
	global.vida_player = vida;
	
	// Avisando que eu tomei dano
	dano = true;
	
	// Garantir que eu posso tomar dano depois de um tempo
	alarm[0] = tempo_inv;
}

// Criando o método de controlar o cajado

usa_arma = function()
{
    if (arma)
    {
        var _fire = mouse_check_button(mb_left) && arma_cooldown <= 0;

        arma.atirar = _fire;

        if (_fire) {
            arma_cooldown = room_speed * 0.2; // define cooldown ao atirar
        }

        var _dir = point_direction(x, y, mouse_x, mouse_y);

        var _x = x + lengthdir_x(sprite_width/100, _dir);
        var _y = y + lengthdir_y(sprite_height/100, _dir);

        arma.x = _x;
        arma.y = _y;
        arma.image_angle = _dir;
    }
}

// Criando o método para me livrar de uma arma

joga_arma = function()
{
	if(arma)
	{
		var _joga = (mouse_check_button_pressed(mb_right));
		var _col;
		// Checando se o cajado está dentro da parede, colidindo com o block
		// Rodando o código de dentro da arma
		with(arma)
		{
			// Isso ta dentro da arma
			_col = place_meeting(x, y, obj_block);
		}
		// Só posso jgar a arma se eu apertei o botao de jogar e se ela não esta na parede
		if(_joga && !_col)
		{
			arma.speed = 4;
			arma.direction = arma.image_angle;
			
			// Avisando que a arma não pode atirar mais
			arma.atirar = false;
			
			// Falando para a arma que eu vou comprar cigarro
			arma.pai = noone;
			
			// Dando um delay para a arma
			arma.delay_pega = room_speed * 2;
			
			arma = noone;
			
		}
	}
}
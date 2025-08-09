// Velocidade de tiro
// Delay do tiro
// Tiro
atirar = false;
tiros_atuais = balas_maximas;


delay_pega = 0;

// Delay para atirar
delay_tiro = 0;

pai = noone;

// Criando o meu método para atirar

atirando = function()
{

	delay_tiro--;
	if (atirar)
	{
		// Criando meu próprio método de contar as balas no if
		if (tiros_atuais > 0)
		{
			if(global.pause) exit;
			// Criando o meu tiro dentro do intervalo

			if(delay_tiro <= 0)
			{
				// Resetando o delay do tiro
				delay_tiro = espera_tiro * room_speed;
				// Atirando
			
				// Achando a posição para criar o meu tiro
				var _x = lengthdir_x(sprite_width, image_angle);
				var _y = lengthdir_y(sprite_width, image_angle);
			
				var _tiro = instance_create_layer(x + _x, y + _y, layer, tiro);
				// Dando velocidade para o tiro
				_tiro.speed = velocidade;
				// Definindo a direção do tiro com base na imprecisão
				_tiro.direction = image_angle + random_range(-imprecisao, imprecisao);
			
				// Empurrando o player
				// Só faço isso se eu tenho um pai (dono?)
				if(pai)
				{
					// Achando o valor do velh e velv com base na direção
					var _velh = lengthdir_x(knockback, image_angle);
					var _velv = lengthdir_y(knockback, image_angle);
				
					pai.velh -= _velh;
					pai.velv -= _velv;
					tiros_atuais -= qtd_tiros;
				}
			}
		}
	}
}

quica_parede = function()
{
	// Batendo na parede e voltando
	// Checar se estou batendo horizontalmenet na parede
	if (place_meeting(x + hspeed, y, obj_block)) hspeed *= -1;
	// Checar a vertical
	if (place_meeting(x, y  + vspeed, obj_block)) vspeed *= -1;
}


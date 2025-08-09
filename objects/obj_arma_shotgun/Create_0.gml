// Inherit the parent event
event_inherited();

atirando = function()
{

	delay_tiro--;
	if (atirar)
	{
		if (tiros_atuais > 0)
		{
			// Criando o meu tiro dentro do intervalo

			if(delay_tiro <= 0)
			{
				// Resetando o delay do tiro
				delay_tiro = espera_tiro * room_speed;
				// Atirando
			
				for(var i = 0; i < qtd_tiros; i++)
				{
					// Achando o valor da direção
					var _val = 45 / (qtd_tiros - 1);
					// Achando a posição para criar o meu tiro
					var _dir = -22.5 + (i * _val);
				
					var _x = lengthdir_x(sprite_width, image_angle + _dir);
					var _y = lengthdir_y(sprite_width, image_angle + _dir);
			
					var _tiro = instance_create_layer(x + _x, y + _y, layer, tiro);
					// Dando velocidade para o tiro
					_tiro.speed = velocidade;
					// Definindo a direção do tiro com base na imprecisão
					_tiro.direction = image_angle + random_range(-imprecisao, imprecisao) + _dir;
				}
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
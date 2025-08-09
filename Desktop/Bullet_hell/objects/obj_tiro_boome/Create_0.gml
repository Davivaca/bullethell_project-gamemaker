// Inherit the parent event
event_inherited();

espera = room_speed * .5;
vel = 0;
rot = -10;

atirado = function()
{
	image_angle += rot;
	// Checar se eu tenho que esperar
	if(espera > 0)
	{
		// Diminuindo o valor da espera
		espera--;
		
		// Checando se eu tenho velocidade
		if (speed != 0)
		{
			vel = speed;
			speed = 0;
		}
	}
	
	// Terminei de esperar agora eu posso me mover
	else
	{
		speed = vel;
	}
}
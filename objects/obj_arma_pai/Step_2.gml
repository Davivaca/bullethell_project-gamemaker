if(global.pause) exit;
atirando();

// Dimuindo o delay
if (delay_pega > 0) delay_pega--;

// Perdendo velocidade
if (speed > 0)
{
	quica_parede();
	
	speed *= 0.9;
	if (speed <= 0.1) speed = 0;
}
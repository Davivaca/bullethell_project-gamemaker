mover(0, 0); // Só pra garantir que a função existe — será sobrescrita depois
estado();


depth = -bbox_bottom;

if(dano)
{
	dano_timer++;
	if(dano_timer > tempo_dano)
	{
		dano_timer = 0;
		dano = false;
	}
}

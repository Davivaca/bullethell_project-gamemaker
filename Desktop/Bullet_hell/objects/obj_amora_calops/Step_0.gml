// Executando o estado atual
estado();

// Arrumando a minha profundidade
depth = -bbox_bottom;

if(dano)
{
	// Se eu tomei dano
	// Aumento o timer
	dano_timer++;
	
	// Resetando o timer SE ele chegou no limite
	if(dano_timer > tempo_dano)
	{
		dano_timer = 0;
		dano = false;
	}
}
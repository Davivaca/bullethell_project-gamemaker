// Variaveis comuns a todos os inimigos
vida_max = 1;
vida_atual = vida_max;

dano = false;

p_dir = 0;

// Variaveis do meu loot
// Chance de dropar o loot
chance = 100;
// Valor do loot
valor = 1;

dropa_loot = function(_chance = 100, _valor = 1)
{
	// Checar se eu posso criar o loot
	// Criando um valor entre 0 e 100
	var _numero = random(100);
	// Se a chance for menor ou igual ao valor eu dropo o item
	if(_chance >= _numero)
	{
		// Criando o loot
		var _loot = instance_create_layer(x, y, "Tiros", obj_drop);
		_loot.image_xscale = .15;
		_loot.image_yscale = .15;
	}else
	{
		show_message(_numero);
	}
	if(_chance != _numero)// ----------------------------------------- NÃO TA FUNCIONANDO
	{
		// Criando o loot CORAÇÃO
		var _loot_cora = instance_create_layer(x, y, "Tiros", obj_drop_heart);
		_loot_cora.image_xscale = .15;
		_loot_cora.image_yscale = .15;
	}
}

// Criando o método de levar dano
///@method  leva_dano(dano)
leva_dano = function(_dano)
{
	// Perdendo vida
	// Se a pessoa não definiu o dano então eu perco 1 de vida
	if(_dano == undefined) vida_atual -= 1;
	// Caso contrario eu perco _dano de vida
	else vida_atual -= _dano;
	
	// Vou avisar que ele levou dano
	dano = true;
}
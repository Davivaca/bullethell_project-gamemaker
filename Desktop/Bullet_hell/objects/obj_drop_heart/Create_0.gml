distancia = 50;
vel = 1;


vai_para_player = function()
{
	// O player existe?
	if(instance_exists(obj_player))
	{
		// Checando se o player está próximo de mim
		var _dist_player = point_distance(x, y, obj_player.x, obj_player.y);
		
		// Achando a direção para o player
		var _dir_player = point_direction(x, y, obj_player.x, obj_player.y);
		
		// SE o player estiver próximo eu vou até ele
		if(_dist_player < distancia)
		{
			speed = vel;
			direction = _dir_player;
		}else
		{
			// O player tá muito longe de mim
			speed = 0;
		}
	}
}
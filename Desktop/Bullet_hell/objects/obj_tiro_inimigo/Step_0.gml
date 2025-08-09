// Step
if(place_meeting(x, y, obj_player))
{
	obj_player.toma_dano();
	instance_destroy();
}

if(place_meeting(x, y, obj_block))
{
	instance_destroy();
}
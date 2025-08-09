if(place_meeting(x + velh, y, obj_block))
{
	var _velh = sign(velh);
	while(!place_meeting(x + _velh, y, obj_block)) x += _velh;
	velh = 0;
}
x += velh;

if(place_meeting(x, y + velv, obj_block))
{
	var _velv = sign(velv);
	while(!place_meeting(x, y + _velv, obj_block)) y += _velv;
	velv = 0;
}
y += velv;

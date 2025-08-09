// Colisão horizontal
if(place_meeting(x + velh, y, obj_block)) {
    var _velh = sign(velh);
    // Enquanto eu não estiver colidindo 1 pixel na direção que estou indo
    while(!place_meeting(x + _velh, y, obj_block)) {
        x += _velh;
    }
    // Se a velocidade na direção for zero, então pare
    if (place_meeting(x + _velh, y, obj_block)) {
        velh = 0;  // Zero velocidade quando atingir o obstáculo
    }
}
x += velh;

// Colisão vertical
if(place_meeting(x, y + velv, obj_block)) {
    var _velv = sign(velv);
    // Enquanto eu não estiver colidindo 1 pixel na direção que estou indo
    while(!place_meeting(x, y + _velv, obj_block)) {
        y += _velv;
    }
    // Se a velocidade na direção for zero, então pare
    if (place_meeting(x, y + _velv, obj_block)) {
        velv = 0;  // Zero velocidade quando atingir o obstáculo
    }
}
y += velv;
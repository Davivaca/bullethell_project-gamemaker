// Se o jogador está dentro da sala e ainda não ativou a lógica
if (!sala_ativada && collision_rectangle(x, y, x + sprite_width, y + sprite_height, obj_jogador, false, true)) {
    sala_ativada = true;
    // Fecha as portas
    with (obj_porta) {
        if (point_in_rectangle(x, y, other.x, other.y, other.x + other.sprite_width, other.y + other.sprite_height)) {
            estado = "fechada";
        }
    }
}

// Se a sala estiver ativada e todos os inimigos estiverem mortos
if (sala_ativada && instance_number(obj_inimigo) == 0 && !porta_fechada) {
    with (obj_porta) {
        if (point_in_rectangle(x, y, other.x, other.y, other.x + other.sprite_width, other.y + other.sprite_height)) {
            estado = "aberta";
        }
    }
    porta_fechada = true;
}

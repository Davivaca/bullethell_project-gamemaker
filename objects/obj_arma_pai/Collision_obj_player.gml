// Colidi com o player eu vou ser a arma dele SE ele não tem arma
// E se o tempo de espera para pegar a arma está zerado

// Colisão obj_arma com player

if (mouse_check_button_pressed(mb_left)) // só no clique apertado
{
    if (other.arma == noone && delay_pega <= 0)
    {
        other.arma = id;
        pai = other.id;

        global.arma_atual = id;

        other.arma_cooldown = room_speed * 0.2; // cooldown local do player
    }
}

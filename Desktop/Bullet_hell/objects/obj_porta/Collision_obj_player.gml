if (estado == "fechada") {
    // Empurra o jogador para fora, por exemplo
    if (other.x < x) {
        other.x = x - other.sprite_width;
    } else {
        other.x = x + sprite_width;
    }
}

// --- EVENTO STEP ---

if (show_dialog) {                         // Só roda se o diálogo estiver ativo
    var full_text = dialog[dialog_index][1];  // Texto completo da fala atual

    // Efeito de digitação (mostrar letra por letra)
    if (!text_done) {                      // Se ainda não terminou de digitar
        type_timer += type_speed;         // Incrementa timer com a velocidade configurada

        if (type_timer >= 1) {            // Se já passou tempo suficiente para mostrar próxima letra
            type_index += floor(type_timer);  // Incrementa índice da letra mostrada
            type_timer -= floor(type_timer);  // Diminui o timer acumulado para não pular letras

            if (type_index >= string_length(full_text)) {  // Se terminou o texto
                type_index = string_length(full_text);    // Ajusta índice para não passar do texto
                text_done = true;                          // Marca que terminou de digitar
            }

            typed_text = string_copy(full_text, 1, type_index);  // Atualiza o texto parcial mostrado
        }
    }

    // Se o jogador clicou com o mouse
    if (mouse_check_button_pressed(mb_left)) {
        if (!text_done) {                  // Se o texto ainda está digitando
            typed_text = full_text;       // Mostra o texto completo de uma vez
            text_done = true;             // Marca texto como terminado
            type_index = string_length(full_text); // Atualiza índice para o fim do texto
        } else {
            dialog_index += 1;            // Avança para o próximo diálogo

            if (dialog_index >= array_length(dialog)) {  // Se acabou o diálogo
                show_dialog = false;      // Desativa o diálogo
                instance_destroy();       // Destroi o objeto para liberar recursos
            } else {
                // Prepara a próxima fala para ser digitada
                type_index = 0;           // Reseta índice de letras
                type_timer = 0;           // Reseta o timer
                text_done = false;        // Marca que o texto ainda não foi digitado
                typed_text = "";          // Reseta o texto mostrado
            }
        }
    }
}
// --- EVENTO CREATE ---

dialog_index = 0; 
// Índice atual do diálogo (qual fala está sendo mostrada)

dialog = [
    ["tutorial", "Hello! Welcome to the game!"],        // Falas e quem fala
    ["player", "Hi..."],
    ["tutorial", "Use the arrow keys or WASD to move."],
    ["tutorial", "Press the left mouse button to pick up weapons, and the right mouse button to throw away your weapon"],
    ["player", "Got it! Thanks!"]
];

show_dialog = true;
// Controla se o diálogo está ativo ou não

// Variáveis para efeito de digitação
typed_text = "";       // Texto que já foi "digitado" e será mostrado
type_speed = 1.5;      // Velocidade da digitação (letras por frame)
type_index = 0;        // Quantidade de letras já exibidas
type_timer = 0;        // Acumula tempo para controlar quando a próxima letra aparece
text_done = false;     // Indica se o texto atual já terminou de ser digitado
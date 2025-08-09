// Proteção: garante que o jogador existe
if (!instance_exists(obj_player)) exit;

// --- POSIÇÃO DO JOGADOR ---
var px = obj_player.x;
var py = obj_player.y;

// --- TAMANHO DA VIEW ---
var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

// --- POSIÇÃO DO MOUSE NO MUNDO ---
var mx = window_mouse_get_x();
var my = window_mouse_get_y();
mx = camera_get_view_x(view_camera[0]) + mx;
my = camera_get_view_y(view_camera[0]) + my;

// --- DESLOCAMENTO PARA O LADO DO MOUSE ---
var offset_strength = 0.1;
var dx = mx - px;
var dy = my - py;
// Calcula alvo do offset com base no mouse
var target_offset_x = dx * offset_strength;
var target_offset_y = dy * offset_strength;

// Suaviza o deslocamento do mouse
var mouse_lerp_speed = 0.1; // Quanto menor, mais lento o movimento do mouse
offset_cam_x = lerp(offset_cam_x, target_offset_x, mouse_lerp_speed);
offset_cam_y = lerp(offset_cam_y, target_offset_y, mouse_lerp_speed);


// --- POSIÇÃO-ALVO DA CÂMERA ---
var target_x = px + offset_cam_x - view_w / 2;
var target_y = py + offset_cam_y - view_h / 2;


// --- LERP PARA SUAVIDADE ---
var current_x = camera_get_view_x(view_camera[0]);
var current_y = camera_get_view_y(view_camera[0]);

var lerp_speed = 0.1; // Aumente se quiser menos suavidade

// --- CÁLCULO FINAL DA POSIÇÃO DA CÂMERA ---
var cam_x = lerp(current_x, target_x, lerp_speed);
var cam_y = lerp(current_y, target_y, lerp_speed);

// --- APLICA A POSIÇÃO ---
camera_set_view_pos(view_camera[0], cam_x, cam_y);

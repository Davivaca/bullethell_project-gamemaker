// Inicializa variáveis de suavização
offset_cam_x = 0;
offset_cam_y = 0;

// Força a câmera começar centralizada no jogador
if (instance_exists(obj_player)) {
    var view_w = camera_get_view_width(view_camera[0]);
    var view_h = camera_get_view_height(view_camera[0]);
    var _x = obj_player.x - view_w / 2;
    var _y = obj_player.y - view_h / 2;
    camera_set_view_pos(view_camera[0], _x, _y);
}

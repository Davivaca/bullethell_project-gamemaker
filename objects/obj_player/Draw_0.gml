draw_sprite_ext(sprite_index, image_index, x, y, visual_dir, image_yscale, image_angle, image_blend, image_alpha);

if (arma != noone) {
    draw_sprite_ext(
        arma.sprite_index, arma.image_index,
        arma.x, arma.y,
        arma.image_xscale, arma.image_yscale,
        arma.image_angle,
        arma.image_blend,
        arma.image_alpha
    );
}

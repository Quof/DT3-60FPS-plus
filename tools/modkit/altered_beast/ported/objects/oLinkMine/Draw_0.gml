draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if lifeTime<=45
{
  draw_set_alpha(1)
  draw_set_halign(fa_middle)
  draw_set_font(fnt_EnemyName)
  textDropShadow(lifeTime,x,y-24,c_white,c_black,3)
}

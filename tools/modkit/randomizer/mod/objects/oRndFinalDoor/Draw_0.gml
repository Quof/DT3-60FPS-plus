draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,make_color_rgb(255,120,120),1)
if instance_exists(oPlayer1)
{
  if point_distance(x+8,y+16,oPlayer1.x,oPlayer1.y)<=96
  {
    draw_set_color(c_white)
    draw_set_alpha(1)
    draw_set_font(fnt_EnemyName)
    draw_set_halign(fa_center)
    draw_text(x+8,y-28,"CHAOS Warmaster#(Up to enter)")
    draw_set_halign(fa_left)
  }
}

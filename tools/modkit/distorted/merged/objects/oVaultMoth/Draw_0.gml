if introAnim>=10
{
  event_inherited()
  if global.deathZonesOn=1
  {
    draw_set_alpha(0.3)
    draw_set_color(c_white)
    draw_circle(x,y-32,12,0)
  }
}
else
{
  if image_xscale<0
    draw_sprite_wave(sprite_index,image_index,x+abs(sprite_width),y,1,12,amplitude,phase)
  else
    draw_sprite_wave(sprite_index,image_index,x,y,1,12,amplitude,phase)
}

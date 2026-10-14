if introAnim>=10 {event_inherited()}
else
{
  if image_xscale<0
    draw_sprite_wave(sprite_index,image_index,x+abs(sprite_width),y,1,12,amplitude,phase)
  else
    draw_sprite_wave(sprite_index,image_index,x,y,1,12,amplitude,phase)
}

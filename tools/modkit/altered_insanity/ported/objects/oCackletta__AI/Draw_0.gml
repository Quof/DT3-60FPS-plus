if life>0
{
  event_inherited()
  if sprite_index=sCacklettaWings
  {
    draw_sprite(sCacklettaHands,-1,x,y-50)
  }
}
else
  draw_sprite_part(sprite_index,0,0,0,sprite_width,sprite_height-hLineEffect,x-(sprite_width/2),y-sprite_height+4+hLineEffect)

//square was here
if atkSequence==4 && ((atkTime>=20 && atkTime<=90) || (atkTime>=120 && atkTime<=190)) {
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,
    make_color_rgb(64,128,88),image_alpha-0.15)
}

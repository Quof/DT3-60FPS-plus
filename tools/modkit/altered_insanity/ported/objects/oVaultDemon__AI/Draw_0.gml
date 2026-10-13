draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if moveType=1
{
  if (shiftAtk>=11 and shiftAtk<=40) or (shiftAtk>=51 and shiftAtk<=80)
  {
    if shiftAtk mod 5=0
    {
      if shiftTempC=0 {shiftTempC=1}
      else {shiftTempC=0}
    }
    if shiftAtk>=50 and bossProgress<=2 {shiftTempC=0}
    for(i=0;i<shiftTempA;i+=1)
    {
      draw_sprite_ext(sWarningSymbol,0,shiftTempB+(i*48),yGround,0.35,0.35,0,c_white,shiftTempC)
    }
  }
}

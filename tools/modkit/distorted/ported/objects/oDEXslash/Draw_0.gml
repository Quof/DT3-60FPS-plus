if atkProg=0
{
  for(i=0;i<3;i+=1)
  {
    draw_sprite_ext(sHexor_GanonOrb,0,x,y,0.5+(i*1.15),0.5+(i*1.15),image_angle,image_blend,0.3-(0.05*i))
  }

  draw_set_alpha(0.75)
  draw_set_color(c_white)
  draw_circle(x,y,myRad,1)
}
else if atkProg=1
{
  draw_self()
}

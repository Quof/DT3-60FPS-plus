for(i=0;i<4;i+=1)
{
  draw_sprite_ext(sBM_Chain,0,x,y,image_xscale,image_yscale,(i*90)+armsRotation,armBlend[i],image_alpha)
}
event_inherited()

if bossPhase=3
{
  draw_set_alpha(1)
  if barrierSet=0 {draw_set_color(c_yellow)}
  else if barrierSet=1 {draw_set_color(c_green)}
  else if barrierSet=2 {draw_set_color(c_red)}
  draw_circle(x,y,32+circleRad,1)
}

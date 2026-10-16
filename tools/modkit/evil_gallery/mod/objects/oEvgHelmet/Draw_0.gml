//Evil Boss Gallery: Evil Helmethead drawn: his body (Helmethead's, through his parents' draw), the head he wears (none
//while it's out on a toss: a red flicker at the open neck instead), the shield up in front during the charge, and the
//barrier
event_inherited()
if headOff=0
{
  if headNum=0 {draw_sprite_ext(sEvgHelmetHeadA,0,x+headShake,y-31,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
  else if headNum=1 {draw_sprite_ext(sEvgHelmetHeadB,0,x+headShake,y-31,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
  else {draw_sprite_ext(sEvgHelmetHeadC,0,x+headShake,y-31,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
}
else
{
  draw_set_alpha(0.4+0.3*sin(waterFrm*2))
  draw_set_color(make_color_rgb(255,40,60))
  draw_circle(x,y-32,3,0)
  draw_set_alpha(1)
  draw_set_color(c_white)
}
if actProg=2 {draw_sprite_ext(sEvgHelmetShield,0,x+(9*image_xscale),y-17,1.5*image_xscale,1.5,0,c_white,1)}
if myBarrier=2 {draw_sprite_ext(sWaterBarrier,waterFrm,x,y-16,0.9,0.9,0,make_color_rgb(255,140,160),0.45)}

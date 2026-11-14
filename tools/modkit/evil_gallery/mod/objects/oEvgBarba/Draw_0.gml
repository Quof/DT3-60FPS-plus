//Evil Boss Gallery: Barba's own draw, and its eyes glowing in the pit before a lunge (low or high: how to get past it)
event_inherited()
if evgMove=1 and evgStage=2
{
  var tY,tA;
  if lungeLow=1 {tY=279}
  else {tY=244}
  tA=0.5+0.5*((floor(evgT/3) mod 2)=0)
  draw_set_alpha(tA)
  draw_set_color(make_color_rgb(255,60,40))
  draw_circle(lungeX-5,tY,3,0)
  draw_circle(lungeX+5,tY,3,0)
  draw_set_color(make_color_rgb(255,200,120))
  draw_circle(lungeX-5,tY,1,0)
  draw_circle(lungeX+5,tY,1,0)
  draw_set_alpha(1)
  draw_set_color(c_white)
}

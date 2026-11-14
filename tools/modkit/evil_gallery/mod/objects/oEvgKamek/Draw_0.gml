//Evil Boss Gallery: Kamek's own draw, and the line of his swoop while it shows (dotted, flashing)
event_inherited()
if evgMove=3 and evgStage=2
{
  var k,tA;
  tA=0.5+0.4*((floor(evgT/2) mod 2)=0)
  draw_set_color(make_color_rgb(220,60,200))
  draw_set_alpha(tA)
  for(k=24;k<420;k+=16)
  {
    draw_circle(x+lengthdir_x(k,swDir),y-22+lengthdir_y(k,swDir),2,0)
  }
  draw_set_alpha(1)
  draw_set_color(c_white)
}

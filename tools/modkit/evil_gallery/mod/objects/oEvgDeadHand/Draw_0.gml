//Evil Boss Gallery: Dead Hand's own draw, the ambush's ring on the floor while the ground rumbles, and the stars of its
//stun after a bomb
event_inherited()
if evgMove=2 and evgStage=1
{
  draw_set_color(make_color_rgb(60,0,20))
  draw_set_alpha(0.35+0.25*((floor(evgT/3) mod 2)=0))
  draw_ellipse(ambX-20,yGround-4,ambX+20,yGround+4,0)
  draw_set_alpha(1)
  draw_set_color(c_white)
}
if evgMove=3 and evgStage=3
{
  var k,tA;
  draw_set_color(make_color_rgb(255,230,150))
  for(k=0;k<3;k+=1)
  {
    tA=evgT*10+k*120
    draw_circle(x+lengthdir_x(14,tA),y-46+lengthdir_y(4,tA),2,0)
  }
  draw_set_color(c_white)
}

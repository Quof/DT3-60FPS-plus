//Evil Boss Gallery: the lava bubble: the lava bubbling where it'll come up (the warning), then a fiery ball with eyes
if prog=0
{
  var k,tX,tY;
  draw_set_color(make_color_rgb(255,150,40))
  for(k=0;k<3;k+=1)
  {
    tX=x-12+(k*12)+3*sin((t+k*7)*0.6)
    tY=y0-2-((t*1.5+(k*5)) mod 8)
    draw_set_alpha(0.8)
    draw_circle(tX,tY,2+((floor(t)+k) mod 2),0)
  }
  draw_set_alpha(1)
  draw_set_color(c_white)
}
else
{
  draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,make_color_rgb(255,170,60),1)
  draw_set_color(c_black)
  var tEy;
  tEy=-2
  if yVel>0 {tEy=2}
  draw_circle(x-3,y+tEy,1,0)
  draw_circle(x+3,y+tEy,1,0)
  draw_set_color(c_white)
}

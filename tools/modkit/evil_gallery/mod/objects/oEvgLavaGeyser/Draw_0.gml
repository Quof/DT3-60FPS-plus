//Evil Boss Gallery: bubbles on the lava (the warning), then the column of lava, flickering, with a splash at its top
if prog=0
{
  var k,tX,tY;
  draw_set_color(make_color_rgb(255,140,40))
  for(k=0;k<4;k+=1)
  {
    tX=cx-12+(k*8)+2*sin((t+k*5)*0.7)
    tY=yLava-2-((t*1.5+(k*4)) mod 10)
    draw_set_alpha(0.85)
    draw_circle(tX,tY,2+((floor(t)+k) mod 2),0)
  }
  draw_set_alpha(1)
  draw_set_color(c_white)
}
else
{
  var tW,tA;
  tW=14
  tA=1
  if prog=2 {tW=14*max(0,1-(t/8)); tA=max(0,1-(t/8))}
  draw_set_alpha(tA)
  draw_set_color(make_color_rgb(200,40,10))
  draw_rectangle(cx-tW,yTopC,cx+tW,yLava+16,0)
  draw_set_color(make_color_rgb(255,150,40))
  draw_rectangle(cx-tW*0.6+2*sin(t*1.3),yTopC,cx+tW*0.6+2*sin(t*1.3),yLava+16,0)
  draw_set_color(make_color_rgb(255,230,150))
  draw_rectangle(cx-tW*0.2,yTopC,cx+tW*0.2,yLava+16,0)
  draw_circle(cx,yTopC+4,tW+3,0)
  draw_set_alpha(1)
  draw_set_color(c_white)
}

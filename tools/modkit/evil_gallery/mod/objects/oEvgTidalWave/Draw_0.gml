//Evil Boss Gallery: the water heaving where the wave will start (growing), then the wave: a curling crest of water
if prog=0
{
  var tH;
  tH=24*min(1,t/warn)
  draw_set_color(make_color_rgb(40,120,170))
  draw_set_alpha(0.6)
  draw_ellipse(x-18,y-tH,x+18,y+4,0)
  draw_set_alpha(1)
  draw_set_color(c_white)
}
else
{
  var tCx;
  tCx=x+10
  draw_set_alpha(0.75)
  draw_set_color(make_color_rgb(30,90,150))
  draw_rectangle(tCx-10-dir*16,y+8,tCx+10,base,0)
  draw_set_color(make_color_rgb(70,160,210))
  draw_ellipse(tCx-12,y,tCx+12,base,0)
  draw_set_color(make_color_rgb(220,240,255))
  draw_ellipse(tCx-6+dir*4,y-2,tCx+8+dir*4,y+8,0)
  draw_set_alpha(1)
  draw_set_color(c_white)
}

//Evil Boss Gallery: the helmet drawn: its polarity's glow round it (red or blue; white while flashing before a swap;
//faint once broken), itself, the warning line under it before a dive, and stars while dazed
var tCol,tA;
if polarity=0 {tCol=make_color_rgb(255,60,60)}
else {tCol=make_color_rgb(80,150,255)}
if polFlash=1 {if (floor(polTime/3) mod 2)=0 {tCol=c_white}}
tA=0.5
if broken=1 {tA=0.2}
draw_sprite_ext(sWaterBarrier,waterFrm,x,y-6,0.5*abs(image_xscale),0.5*image_yscale,0,tCol,tA)
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
if mode=1 and diveStage=1
{
  draw_set_alpha(0.3+0.3*((floor(modeT/2) mod 2)=0))
  draw_set_color(make_color_rgb(255,60,60))
  draw_line_width(x,y,x,304,2)
  draw_set_alpha(1)
  draw_set_color(c_white)
}
if mode=2
{
  var k,tAng;
  draw_set_color(make_color_rgb(255,240,120))
  for(k=0;k<3;k+=1)
  {
    tAng=modeT*8+k*120
    draw_circle(x+lengthdir_x(9,tAng),y-16+lengthdir_y(3,tAng),1.5,0)
  }
  draw_set_color(c_white)
}

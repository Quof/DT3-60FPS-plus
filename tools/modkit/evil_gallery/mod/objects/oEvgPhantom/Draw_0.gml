//Evil Boss Gallery: the warning band across the arena at the phantom's height (arrows moving the way it'll come), then
//the phantom (Death's roll, spinning) with its afterimages
var tCx,tCy,tA,k,tAx;
tCx=x+14
tCy=y+24
if prog=0
{
  tA=0.12+0.16*((floor(t/3) mod 2)=0)
  draw_set_color(make_color_rgb(200,20,50))
  draw_set_alpha(tA)
  draw_rectangle(0,y,room_width,y+48,0)
  draw_set_alpha(tA+0.3)
  for(k=-48;k<room_width+48;k+=48)
  {
    tAx=k+((t*4) mod 48)*dir
    draw_line_width(tAx-6*dir,tCy-10,tAx+6*dir,tCy,2)
    draw_line_width(tAx+6*dir,tCy,tAx-6*dir,tCy+10,2)
  }
  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_sprite_ext(sEvgDeathRoll,0,tCx,tCy,0.5*dir,0.5,spinA,c_white,min(1,t/warnTime)*0.8)
}
else
{
  for(k=3;k>=1;k-=1)
  {
    draw_sprite_ext(sEvgDeathRoll,0,tCx-(dir*k*16),tCy,0.5*dir,0.5,spinA+(k*25*dir),c_white,0.3-(0.07*k))
  }
  draw_sprite_ext(sEvgDeathRoll,0,tCx,tCy,0.5*dir,0.5,spinA,c_white,0.9)
}

//Evil Boss Gallery: the sickle, with the line it'll fly along while it aims (flashing)
if prog=1
{
  draw_set_color(make_color_rgb(220,40,70))
  draw_set_alpha(0.25+0.35*((floor(t/2) mod 2)=0))
  draw_line(x,y,x+lengthdir_x(720,aimDir),y+lengthdir_y(720,aimDir))
  draw_set_alpha(1)
  draw_set_color(c_white)
}
var tBlend;
tBlend=image_blend
if prog=1
{
  if (floor(t/2) mod 2)=0 {tBlend=make_color_rgb(255,170,170)}
}
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,tBlend,image_alpha)

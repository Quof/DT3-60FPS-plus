//Evil Boss Gallery: the flame; while it waits, its brick glows and a small flame flickers on it (the warning)
if prog=0
{
  var tA;
  tA=0.35+0.3*((floor(flameT/3) mod 2)=0)
  draw_set_color(make_color_rgb(255,90,40))
  draw_set_alpha(tA*0.7)
  draw_rectangle(x-8,y-2,x+7,y+1,0)
  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,0.3,0,c_white,tA)
}
else {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,1)}

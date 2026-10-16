//Evil Boss Gallery: Evil Bowser drawn: himself (flashing red while locked on for the meteor), the hammer he holds up
//before the volley, and under him at the ceiling the spot he'll land on (a dark shadow on the floor, a red line down to it
//once he's locked on)
var tBlend,tFloor,yy,cx;
tBlend=image_blend
if atkProg=23 {if (floor(evgTime/2) mod 2)=0 {tBlend=make_color_rgb(255,70,70)}}
if atkProg=22 or atkProg=23
{
  //(the floor under him: the highest brick, bottom block or switch in his column)
  tFloor=-1
  cx=floor(x/16)*16+8
  for(yy=256;yy<=336;yy+=16)
  {
    if tFloor<0
    {
      if position_meeting(cx,yy+8,oSolid) {tFloor=yy}
    }
  }
  if tFloor>=0
  {
    draw_set_alpha(0.35+0.2*(atkProg=23))
    draw_set_color(c_black)
    draw_ellipse(x-18,tFloor-4,x+18,tFloor+3,0)
    if atkProg=23
    {
      draw_set_alpha(0.5)
      draw_set_color(make_color_rgb(255,60,60))
      draw_line_width(x,y,x,tFloor,2)
    }
    draw_set_alpha(1)
    draw_set_color(c_white)
  }
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,tBlend,image_alpha)
if atkProg=10 {draw_sprite_ext(sHammerBHam,0,x-(6*image_xscale),y-44,1,1,20*sin(evgTime*0.6)*image_xscale,c_white,1)}

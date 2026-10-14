draw_self()
if atkProg=1
{
  if circleWarnRad>0
  {
    draw_set_alpha(0.2)
    draw_set_color(c_red)
    if room!=rDragoonMapA {draw_line(x+(4*image_xscale),y,x+(room_width*image_xscale),y)}       //spsp
    else {draw_set_alpha(0.8); draw_line(x+(4*image_xscale),y,x+(room_width*image_xscale),y)}
  }

  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_circle(x+(4*image_xscale),y,circleWarnRad,1)
}

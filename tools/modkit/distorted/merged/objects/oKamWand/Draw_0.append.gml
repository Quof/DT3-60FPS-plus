event_inherited()
if fanTime>0
{
  draw_set_alpha(0.6)
  r=point_distance(x,y,oPlayer1.x,returnPlayerYCenter())
  for(i=0;i<6;i+=1) //60 total angle width
  {
    omega=image_angle-(30-i*12)*fanTime/fanMax
    draw_line_color(x,y,x+r*cos(2*pi*omega/360),y-r*sin(2*pi*omega/360),c_white,c_white)
    if i=1 {i+=2} //skip middle
  }
}

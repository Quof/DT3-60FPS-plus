//used to be invisible
//should work like this in bonus rooms as well with conditional draw event cancelling
//said cancelling is not yet implemented

/*if checkScreenArea(x,y,240)=1
{
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_rectangle(x,y,x+48-1,y+48-1,0)
  draw_set_alpha(0.9)
  draw_rectangle(x,y,x+48-1,y+48-1,1)
}*/
if checkScreenArea(x,y,240)=1
{
  draw_set_color(image_blend)
  draw_set_alpha(0.9)
  draw_circle(x,y,zoneRadius,1) //line
  draw_set_alpha(innerAlpha)
  draw_circle(x,y,zoneRadius,false) //fill
}

if bActive=true
{
  if shotTime>=shotDelay
  {
    draw_set_alpha(1)
    if !collision_line(x,y,oPlayer1.x,oPlayer1.y-24,oSolid,true,true)
      draw_set_color(c_red)
    else
      draw_set_color(c_blue)
    draw_line_width(x,y,oPlayer1.x,oPlayer1.y-24,lineW)
  }
}
event_inherited()

if lineON// and global.gamePaused=false
{
  draw_set_alpha(0.5) //new
  for(i=0;i<spokes;i+=1)
  {
    draw_line_width_color(x,y,myPoints[i].x,myPoints[i].y,lineWidth,c_white,c_white) //alpha?
  }
}

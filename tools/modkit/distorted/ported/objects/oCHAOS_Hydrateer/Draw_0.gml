if bLaser=1
{
  //laserCrawl+=2
  laserCrawl+=2*gDeltaTime //60fps change: the aiming dots crawled 2x/4x too fast at 60/120fps
  if laserCrawl>12 {laserCrawl=0}
  draw_set_alpha(1)
  draw_set_color(circleCol)
  for(i=0;i<24;i+=1)
  {
    draw_circle(x+(xOffset*image_xscale)+lengthdir_x((12*i)+laserCrawl,laserDir),y+yOffset+lengthdir_y((12*i)+laserCrawl,laserDir),circleRad,0)
  }
}
event_inherited()

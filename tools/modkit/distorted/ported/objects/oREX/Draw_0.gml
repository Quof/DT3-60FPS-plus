if bLaser=1
{
  //laserCrawl+=2
  laserCrawl+=2*gDeltaTime //60fps change: the aiming dots crawled 2x/4x too fast at 60/120fps (as DT3+'s oCHAOS_Rocketeer)
  if laserCrawl>12 {laserCrawl=0}
  draw_set_alpha(1)
  draw_set_color(circleCol)
  for(i=0;i<24;i+=1)
  {
    draw_circle(x+(xOffset*image_xscale)+lengthdir_x((12*i)+laserCrawl,laserDir),y+yOffset+lengthdir_y((12*i)+laserCrawl,laserDir),circleRad,0)
  }
}

event_inherited()

draw_set_color(c_black)
draw_set_alpha(image_alpha)

if bossProgress>=1 {draw_sprite_ext(sShroudLBody,image_index,x,y-26,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}

if bossProgress>=3 and bossProgress<6 and instance_exists(oShroudlerHand)
{
    if instance_number(oShroudlerHand)=2
    {
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_black,image_alpha)
    }
    else if instance_number(oShroudlerHand)=1
    {
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_gray,image_alpha)
    }
}
else if bossProgress>=6 and instance_exists(oShroudlerHand)
{
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_black,image_alpha)
}
else
{
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

//ball
if ballTime>0
{
    draw_set_color(c_white)
    draw_circle(x,y,ballDelay-ballTime,1)
    draw_set_color(c_black)
    ballScale=1-(ballDelay-ballTime)/100
    draw_sprite_ext(sHexor_ShotA,0,x,y,ballScale,ballScale,360-ballTime*8,c_white,ballScale)
}

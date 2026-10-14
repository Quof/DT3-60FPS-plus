//spsp ns for ANGER only
if global.gamePaused=false and chase=1
{
  //atime+=1
  //image_angle-=20
  atime+=1*gDeltaTime //60fps change: per frame
  image_angle-=20*gDeltaTime //60fps change: per frame
  if atime=30
  {
    aangle=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    xvel=lengthdir_x(aspeed,aangle)
    yvel=lengthdir_y(aspeed,aangle)
  }
  //else if atime>30 and atime<=630 {x+=xvel; y+=yvel}
  else if atime>30 and atime<=630 {x+=xvel*gDeltaTime; y+=yvel*gDeltaTime} //60fps change: per frame
  else if atime>630 {instance_destroy()}
}

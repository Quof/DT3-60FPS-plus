if global.gamePaused=false
{
  x=oPlayer1.x
  y=oPlayer1.y-14
  //image_angle-=rotateSpeed
  //lifeTime-=1
  image_angle-=rotateSpeed*gDeltaTime //60fps change
  lifeTime-=1*gDeltaTime //60fps change
  if lifeTime = 0
  {
    instance_destroy()
  }
}

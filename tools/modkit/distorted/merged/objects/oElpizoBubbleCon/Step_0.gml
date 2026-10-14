if global.gamePaused=false
{
  //if bulletSpeed<7 {bulletSpeed+=0.33} // orig: 8
  //speed=bulletSpeed
  //turn_toward_direction(point_direction(x,y,oPlayer1.x,oPlayer1.y-26),4.5)
  bulletSpeed=scrTickAcc(bulletSpeed,0.33*(bulletSpeed<7),0) //60fps change: speed up per 30fps tick (scrTickAcc), up to Distorted's 7 (orig: 8)
  _speed=bulletSpeed+scrTickAccB(0) //60fps change
  turn_toward_directionUnderscore(point_direction(x,y,oPlayer1.x,oPlayer1.y-26),4.5) //60fps change

  for(i=0;i<bubbleAmount;i+=1)
  {
    myBubble[i].x=x+lengthdir_x(bubbleRadius,(i*360/bubbleAmount)+bubbleDir)
    myBubble[i].y=y+lengthdir_y(bubbleRadius,(i*360/bubbleAmount)+bubbleDir)
  }
  bubbleDir+=15*gDeltaTime

  decayTime-=1*gDeltaTime
  if decayTime<=0
  {
    for(i=0;i<bubbleAmount;i+=1)
    {
      tEffect=instance_create(myBubble[i].x,myBubble[i].y,oEffect)
      tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      with myBubble[i] {instance_destroy()}
    }
    instance_destroy()
  }
}
else {_speed=0}

correctSpeedDirection(self)

if global.gamePaused=false
{
  //bombTime+=1
  bombTime+=1*gDeltaTime //60fps change: per frame (the mod check below is on whole ticks, so it still hits once each)
  if bombTime mod bombDelay=0
  {
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower; newAttack.decayTime=-100
    newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
    newAttack.image_xscale=bombSize; newAttack.image_yscale=bombSize
  }
  
  yVel=scrGravAcc(yVel,grav,1)
  if yVel<0 {image_angle=90}
  else if yVel>0 {image_angle=270}

  if isCollisionBottom(1)
    instance_destroy()
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if y>room_height+32
    instance_destroy()
}

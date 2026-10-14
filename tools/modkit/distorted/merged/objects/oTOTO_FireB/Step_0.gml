if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  _speed=mySpd
  image_angle=_direction

  if global.location!=107 //spsp ns, don't kill ridley bullets
  {
  if isCollisionSolid()
  {
    myAtk=instance_create(x,y,oDamageExplosion)
    myAtk.atkPower=atkPower; myAtk.sprite_index=sBombExplosion
    myAtk.image_xscale=1.75; myAtk.image_yscale=1.75; myAtk.decayTime=-100

    instance_destroy()
  }
}
}
else {_speed=0}

correctSpeedDirection(self)

if global.gamePaused=false
{
  _speed=bulletSpeed
  if sprite_index=sSE_DarkBall {image_angle-=20*gDeltaTime}
  else {image_angle=_direction}

  /*if !variable_local_exists("peTk") {peTk=0} //60fps change (added): counts this bullet's 30fps ticks
  //if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed
  if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed and frac(peTk)=0 //60fps change: checked once per 30fps tick (before that tick's move) like at 30fps
  {
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower; newAttack.decayTime=-100
    newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
    newAttack.image_xscale=1.25; newAttack.image_yscale=1.25
    if sprite_index=sSE_DarkBall {newAttack.image_blend=c_purple}
    instance_destroy()
  }*/
  //_speed=0
  //60fps change: removed the "_speed=0" above; it ran every step right before correctSpeedDirection, so this bullet never moved at all
  //peTk+=gDeltaTime //60fps change (added); commented out with the check above, the only place it's used
}
else {_speed=0; _speed=0}
correctSpeedDirection(self)

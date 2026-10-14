if global.gamePaused=false
{
  if init=0 {init=1}
  if decayTime!=-100
  {
    decayTime-=1*gDeltaTime
    if decayTime<=0 {instance_destroy()}
  }

  if sprite_index=sOOstrichDownWave //spsp ns
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
  }
  
  if place_meeting(x,y,oNightmareEffect) {_speed=bulletSpeed/2}
  else {_speed=bulletSpeed}
  image_angle=_direction
}
else {_speed=0}
//correctSpeedDirection(self)
x+=cos(degtorad(_direction))*_speed*gDeltaTime; y-=sin(degtorad(_direction))*_speed*gDeltaTime //60fps change: the same move as
//correctSpeedDirection without the script call (Create sets both): hundreds of these can be out at once (e.g. Shadow Eura's
//blood volleys), and at 60/120fps the call's cost every frame for each of them lagged

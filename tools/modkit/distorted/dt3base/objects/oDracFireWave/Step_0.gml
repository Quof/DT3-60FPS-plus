if global.gamePaused=false
{
  if atkProg=0
  {
    image_index+=0.045*gDeltaTime
    if image_index>=2.85
    {
      sprite_index=sDraculaFireWave
      image_speed=0.33
      image_yscale=9
      bCanDealDamage=1
      atkProg+=1
    }
  }
  else
  {
    atkProg+=1*gDeltaTime
    if atkProg>=75 {instance_destroy()}
  }
}

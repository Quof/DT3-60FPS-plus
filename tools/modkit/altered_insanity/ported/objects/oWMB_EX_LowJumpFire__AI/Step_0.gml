if global.gamePaused=false
{
  if atkProg=0
  {
    atkTime+=1*gDeltaTime
    if atkTime=8 {image_index=1}
    else if atkTime=16 {image_index=2}
    if atkTime>=24
    {
      playSound(global.snd_Bobomb,0,0.91,30000)
      sprite_index=sEfFirePillar
      bCanDealDamage=1
      atkTime=0; atkProg+=1
    }
  }
  else
  {
    atkTime+=1*gDeltaTime
    if atkTime=1 {image_index=1}
    else if atkTime=2 {image_index=2}
    else if atkTime=3 {image_index=3}
    else if atkTime=4 {image_index=4}
    else if atkTime=5 {image_index=5}
    else if atkTime>=6 {instance_destroy()}
  }
}

if global.gamePaused=false
{
  if atkProg=0
  {
    atkTime+=1*gDeltaTime
    if atkTime=9 {image_index=1}
    else if atkTime=18 {image_index=2}
    if atkTime>=25
    {
      playSound(global.snd_Bobomb,0,0.91,30000)
      sprite_index=sEfFirePillar
      bCanDealDamage=1
      atkTime=0; atkProg+=1
      if global.activeCharacter=3
      {
      image_yscale = 3
      }
    }
  }
  else
  {
    atkTime+=1*gDeltaTime
    if atkTime=3 {image_index=1}
    else if atkTime=6 {image_index=2}
    else if atkTime=9 {image_index=3}
    else if atkTime=12 {image_index=4}
    else if atkTime=15 {image_index=5}
    else if atkTime>=17 {instance_destroy()}
  }
}

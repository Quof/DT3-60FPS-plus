if global.gamePaused=false
{
  x=oPlayer1.x
  y=returnPlayerYCenter()

  if atkProg=0
  {
    myRad-=1*gDeltaTime
    if myRad<=0
    {
      playSound(global.snd_DeathSlash,0,1,1)
      image_xscale*=2
      bCanDealDamage=1
      atkProg=1
    }
  }
  else if atkProg=1
  {
    atkTime+=1*gDeltaTime
    if atkTime=2 {image_index=1}
    else if atkTime=3 {image_index=2}
    else if atkTime=4 {image_index=3}
    else if atkTime=6 {image_index=4}
    else if atkTime=7 {instance_destroy()}
  }
}

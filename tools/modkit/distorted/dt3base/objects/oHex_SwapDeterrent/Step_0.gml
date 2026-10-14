if global.gamePaused=false
{
  if life>0
  {
    if oPlayer1.charSwapRecover>0 {atkPower=16}
    else {atkPower=8}

    if atkProg=0
    {
      x=oPlayerIdle.x; y=oPlayerIdle.y-26
      image_angle+=30*gDeltaTime
      image_xscale-=0.075*gDeltaTime; image_yscale-=0.075*gDeltaTime
      image_alpha+=0.04*gDeltaTime
      if image_alpha>=1
      {
        bCanDealDamage=1; bCanTakeDamage=1
        image_alpha=1; image_xscale=1; image_yscale=1
        atkProg=1
      }
    }
    else if atkProg=1
    {
      image_angle-=3*gDeltaTime
      if point_distance(x,y,oPlayerIdle.x,oPlayerIdle.y-26)>12
      {
        snapDelay+=1*gDeltaTime
        if snapDelay>=5 {x=oPlayerIdle.x; y=oPlayerIdle.y-26}
      }
      else {snapDelay=0}

      //Snap to idle character
      if oGame.time mod (3/gDeltaTime)=0
      {
        if lightningYscale=1 {lightningYscale=-1}
        else {lightningYscale=1}
      }

      //Sap progress
      sappingDelay+=1*gDeltaTime
      if sappingDelay=600 {sapProg=1}
      else if sappingDelay=750 {sapProg=2}
      else if sappingDelay=900
      {
        sapProg=3
        instance_create(x,y,oHex_Sapper)
      }
    }
  }
  else if life<=0
  {
    sapProg=0
    with oHex_Sapper {instance_destroy()}
    bCanDealDamage=0; bCanTakeDamage=0
    image_xscale+=0.05*gDeltaTime; image_yscale+=0.05*gDeltaTime
    image_alpha-=0.05*gDeltaTime
    if image_alpha<=0 {instance_destroy()}
  }
  enemyStepEvent()
}

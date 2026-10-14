if global.gamePaused=false
{
  if life>0
  {
    decayTime-=1*gDeltaTime
    if decayTime<=0 {instance_destroy()}
    
    if instance_exists(oElpizoHitSpot)
    //{oElpizoHitSpot.life+=1}
    {if gDeltaDoTicks {oElpizoHitSpot.life+=1}} //60fps change: once per 30fps tick, in whole points
  }
  else
  {
    image_xscale-=0.1*gDeltaTime; image_yscale-=0.1*gDeltaTime
    if image_xscale<=0 {instance_destroy()}
  }
  enemyStepEvent()
}

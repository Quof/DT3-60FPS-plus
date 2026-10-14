if global.gamePaused=false
{
  if life>0
  {
    if oDAbomMain.instrumentActNum>=8 {bCanTakeDamage=1} //spsp ns originally only needed 6
    else {bCanTakeDamage=0}
    animFrm+=image_speed*gDeltaTime
    
    if bombflag>0
    {
      //BSturn+=0.33
      BSturn+=0.33*gDeltaTime //60fps change: per frame
      BSturn-=6*(BSturn>=6)
      if bombflag=1
      {
        //BStimer+=1
        BStimer+=1*gDeltaTime //60fps change: per frame
        if BStimer>=BSdelay {BStimer=0; bombflag=2}
      }
    }
  }
  enemyStepEvent()

  if life<=0 //Defeat animation
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      bCanTakeDamage=0; bCanDealDamage=0
    }
    if deathAnim>=1
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      if gDeltaDoTicks {tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0}

      image_alpha-=0.02*gDeltaTime
      if image_alpha<=0
      {
        instance_create(x+heartOffsetX,y,oHealthPickup)
        instance_destroy()
      }
    }
  }
}
correctSpeedDirection(self)

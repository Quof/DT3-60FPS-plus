if bCanTakeDamage=true
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND)
      other.yAdjust=-12
    if platformCharacterIs(IN_AIR)
      other.yAdjust=0
  }
  veloAssist=0
  if oPlayer1.yVel>0
    veloAssist=round(oPlayer1.yVel/2)

  if bbox_bottom+yAdjust+veloAssist<oPlayer1.bbox_bottom
  {
    if bCanDealDamage=true
    {
      with other
        hitPlayer(other)
    }
  }
  else
  {
    if global.hasAbilToken[0]>=2 and oPlayer1.starmanTime<=0
    {
      if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true and oPlayer1.dashInvulnerabilityTime=0
      {
        with oPlayer1
        {
          if platformCharacterIs(ON_GROUND)
            yVel=-2
          if platformCharacterIs(IN_AIR)
          {
            if kJump or kUp
              yVel=-13.5
            else
              yVel=-6.5
          }
          if gDeltaTime!=1 {yVel+=gravityIntensity*0.5} //60fps change (added): stomp bounce: same half-gravity correction as the player's own jumps above 30fps (pMoveDoubleJump)
          scrSlowFall(5,0.4,0)
          y-=16
        }

        //Damage effect
        var tFlash,tEffect;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.5
        tFlash.fadeSpeed=0.1
        playSound(global.snd_MarioStomp,0,0.98,1)
        for(i=0;i<9;i+=1)
        {
          tEffect=instance_create(x-12+random(24),bbox_top+8,oKillEffect)
          tEffect.speed=5; tEffect.direction=55+(i*8)+random(4)
          tEffect.friction=0.1+random(0.3); tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
        }
        oPlayer1.canAirDash=1
        oPlayer1.doubleJumpCheck=1
        life-=1 //Damage Cackletta
        sprite_index=sCacklettaIdle
        timeTillReHit=50
        bCanDealDamage=false
        bCanTakeDamage=false
        //atkSequence=0 //spsp ns shouldn't be necessary
        //atkTime=0
        if life=2 or life=1 //spsp ns =1
        {
          myHeartDrop=instance_create(x,y-24,oHealthPickup)
        }
        if life=0 //Boss defeat
        {
          sprite_index=sCacklettaDefeat
          bCanDealDamage=false
          atkSequence=0
          atkTime=0
        }
      }
    }
    else
    {
      if bCanDealDamage=true
      {
        with other
          hitPlayer(other)
      }
    }
  }
}
else
{
  if bCanDealDamage=true
  {
    with other
      hitPlayer(other)
  }
}

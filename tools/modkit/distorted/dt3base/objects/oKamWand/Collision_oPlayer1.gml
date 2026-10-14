if bCanTakeDamage=true
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND)
      other.yAdjust=-8
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
      var tDmgCheck;
      tDmgCheck=0
      if oPlayer1.sprite_index!=sJerryDamaged and oPlayer1.sprite_index!=sClaireDamaged
      {
        if oPlayer1.sprite_index!=sJerryDamaged and oPlayer1.sprite_index!=sClaireDamaged
        {
          if oPlayer1.bCanTakeHit=true
          {
            if oPlayer1.dashInvulnerabilityTime=0
              tDmgCheck=1
          }
          else
          {
            if oPlayer1.dashInvulnerabilityTime=0 and oPlayer1.yVel>0
              tDmgCheck=1
          }
        }

        if tDmgCheck=1
        {
          with oPlayer1
          {
            if platformCharacterIs(ON_GROUND)
              yVel=-2
            if platformCharacterIs(IN_AIR)
            {
              if oPlayer1.jumpTime<oPlayer1.jumpTimeTotal-5
                oPlayer1.jumpTime=oPlayer1.jumpTimeTotal-5
              if kJump or kUp
                yVel=-13.5
              else
                yVel=-6.5
            }
            if gDeltaTime!=1 {yVel+=gravityIntensity*0.5} //60fps change (added): stomp bounce: same half-gravity correction as the player's own jumps above 30fps (pMoveDoubleJump)
          }

          //Damage effect
          var tEffect;
          playSound(global.snd_MarioStomp,0,0.98,1)
          for(i=0;i<9;i+=1)
          {
            tEffect=instance_create(x-12+random(24),bbox_top+8,oKillEffect)
            tEffect.speed=5; tEffect.direction=55+(i*8)+random(4)
            tEffect.friction=0.1+random(0.3); tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
          }
          life-=1 //Damage Boss
          bCanTakeDamage=false
          bCanDealDamage=false
          hitStateTime=60
          atkSequence=5
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

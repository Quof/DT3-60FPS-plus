if global.gamePaused=false
{
  if y>oPlayer1.y and bActive=false {makeEnemyActive(1)}

  if bActive=true and life>0
  {
    makeEnemyActive(1)
    if rising>=0 and rising<=99
    {
      rising+=1*gDeltaTime
      if rising=1
      {
        var tEffect;
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(x+random_range(-12,12),y-19+random_range(-17,17),oEffect)
          tEffect.sprite_index=sWitchFire; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100
          tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_blend=c_maroon
        }
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        yVel=-12
        visible=1
      }

      if yVel<12 {yVel=scrGravAcc(yVel,0.5,1)}
      if yVel>5
      {
        if isCollisionBottom(1)
        {
          yVel=0
          image_speed=0.15
          sprite_index=sPT_LavaBeast_Walk
          detectDistX=264
          detectDistY=200
          bCanTakeDamage=true
          rising=100
        }
        moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
      }
      else
      {
        y+=yVel*gDeltaTime
      }
    }
    else if rising>=100
    {
      if sprite_index=sPT_LavaBeast_Walk
      {
        if x<oPlayer1.x {image_xscale=1; xVel=runAcc}
        else {image_xscale=-1; xVel=-runAcc}
      }

      //Check if at cliff edge and turn around
      tDrop=0
      if aiCheckHoriz(1,1,0,8,4)
      {
        if aiCheckVert(0,1,8,8,4)=1
          tDrop=1
      }
      if tDrop=0
      {
        xVel*=-1
        turnTime=25
      }

      //---------- Throw Fireball ----------
      atkTime+=1*gDeltaTime
      if atkTime>=atkDelay
      {
        if atkTime=atkDelay //Change anim
        {
          xVel=0
          sprite_index=sPT_LavaBeast_Ready
          image_index=0
        }
        else if atkTime=atkDelay+12
        {
          playSound(global.snd_Fireball,0,0.9,18000)
          sprite_index=sPT_LavaBeast_Throw
          var tNewAttack;
          tNewAttack=instance_create(x+(18*image_xscale),y-31,oPassBullet)
          tNewAttack.sprite_index=sDraculaFireball; tNewAttack.atkPower=atkPower; tNewAttack.image_speed=0.5; tNewAttack.decayTime=-100
          tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=300; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
          if aimAtk=1
          {
            if image_xscale=1 {tNewAttack._direction=0}
            else {tNewAttack._direction=180}
            tNewAttack.bulletSpeed=13
          }
          else
          {
            tNewAttack._direction=point_direction(x+(18*image_xscale),y-31,oPlayer1.x,oPlayer1.y-26)
            tNewAttack.bulletSpeed=12
          }
        }
        else if atkTime=atkDelay+15 {image_index=1}
        else if atkTime=atkDelay+18 {image_index=2}
        else if atkTime=atkDelay+21 //End attack
        {
          sprite_index=sPT_LavaBeast_Walk
          if aimAtk=1 {aimAtk=3}
          else {aimAtk=1}
          atkTime=0
        }
      }

      yVel=scrGravAcc(yVel,0.3,1)
      if isCollisionBottom(1)
        yVel=0
      if isCollisionLeft(1)
        xVel=runAcc
      if isCollisionRight(1)
        xVel=-runAcc
      if isCollisionSolid()
        y-=2

      moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
      if y>room_height+24
      {
        if questType>0 {enemyQuest(questType)}
        instance_destroy()
      }
    }
  }
  else if life<=0
  {
    //deathAnim+=1
    deathAnim+=1*gDeltaTime //60fps change: counted per frame, so the death flames and sounds came 2x/4x as often at 60/120fps
    _speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-11,11),y-1-random(44),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
correctSpeedDirection(self)

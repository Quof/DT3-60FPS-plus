if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay)
    showBossHP.bossID=id
    showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //---------- MOVEMENT ----------
    if sprite_index=sHHG_Idle
    {
      if x>oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}
      image_index+=0.2*gDeltaTime
    }

    waitTime+=1*gDeltaTime
    if waitTime>=waitDelay
    {
      if actCheck=0 //---------- Choose an action ----------
      {
        if atkNum=0 //----- First attack -----
        {
          if point_distance(x,0,oPlayer1.x,0)<64 //-- Player is close --
          {
            if oPlayer1.attackState=0 //Player is not attacking
            {
              actCheck=10
              currentAtk=0
            }
            else //Player is attacking
            {
              actCheck=2
            }
          }
          else //-- Player is far --
          {
            if oPlayer1.attackState=0 //Player is not attacking
            {
              actCheck=1
            }
            else //Player is attacking
            {
              actCheck=3
            }
          }
        }
        else if atkNum>=1 //----- Second attack -----
        {
          if point_distance(x,0,oPlayer1.x,0)<64 //-- Player is close --
          {
            if oPlayer1.attackState=0 //Player is not attacking
            {
              actCheck=10
              currentAtk=1
            }
            else //Player is attacking
            {
              actCheck=2
              altAtk=1
            }
          }
          else //-- Player is far --
          {
            if oPlayer1.attackState=0 //Player is not attacking
            {
              actCheck=3
            }
            else //Player is attacking
            {
              actCheck=1
            }
          }
        }
      }
      else if actCheck=1 //---------- Jump ----------
      {
        actTime+=1*gDeltaTime
        if actTime=1
        {
          xVel=3*image_xscale
          y-=2
          yVel=-5
          sprite_index=sHHG_Jump
        }
        else if actTime>=10
        {
          actTime=0
          actCheck=10
          if altAtk=0 {currentAtk=0}
          else {actCheck=3}
        }
      }
      else if actCheck=2 //---------- Dash back ----------
      {
        actTime+=1*gDeltaTime
        if actTime=1
        {
          xVel=3.5*-image_xscale
          sprite_index=sHHG_DashBack
          if atkSpd>=1 {actTime=4}
        }
        else if actTime=8
        {
          if altAtk=1 {actTime=0; actCheck=3}
        }
        else if actTime>=10
        {
          xVel=0
          actTime=0
          actCheck=10
          currentAtk=1
        }
      }
      else if actCheck=3 //---------- Dash forward ----------
      {
        actTime+=1*gDeltaTime
        if actTime=1
        {
          xVel=6*image_xscale
          sprite_index=sHHG_DashForward
          if atkSpd>=1 {actTime=4}
        }
        else if actTime>=10
        {
          slowVel=1
          altAtk=2
          actTime=0
          actCheck=10
          currentAtk=1
        }
      }
      else if actCheck=10 //---------- Execute action ----------
      {
        event_user(currentAtk)
      }
    }

    if slowVel=1 //Slow down a dash
    {
      if xVel>1 or xVel<-1 {xVel=scrTickAcc(xVel,0.33*((xVel<-1)-(xVel>1)),0)} //slow down toward 0, per 30fps tick (scrTickAcc)
      else {xVel=0; slowVel=0}
    }

    yVel=scrGravAcc(yVel,0.4,1)
    if isCollisionBottom(1)
    {
      yVel=0
    }
    if isCollisionLeft(1)
    {
      xVel=1
    }
    if isCollisionRight(1)
    {
      xVel=-1
    }
    if isCollisionSolid()
      y-=2

    moveTo((xVel+scrTickAccB(0))*gDeltaTime,yVel*gDeltaTime)

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.83 and lifePercent>=0.66 and bossProgress=0
    {
      waitDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.65 and lifePercent>=0.51 and bossProgress=1
    {
      waitDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.31 and bossProgress=2
    {
      waitDelay-=4
      atkMax=3
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0 and bossProgress=3
    {
      waitDelay-=4
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
      sprite_index=sHHG_Hit
    }
    //else if deathAnim>=2 and deathAnim<=49
    else if deathAnim>1 and deathAnim<=49 //60fps change: includes every frame of tick 2, not just its last one
    {
      if oGame.time mod (2/gDeltaTime)=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=50
    {
      if global.bBossGallery=1
      {
        bossRoomTally(43)
        global.newMapX=2392; global.newMapY=464; room_goto(rBossGallery)
      }
      else
      {
        oEvCh15MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}

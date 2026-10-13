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
    if sprite_index=sSeph_Idle
    {
      if x>oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}
      image_index+=0.2*gDeltaTime
    }

    if meteor<metStormFreq
    {
      waitTime+=1*gDeltaTime
      if waitTime>=waitDelay
      {
        if actCheck=0 //---------- Choose an action ----------
        {
          if atkNum=0 //----- First attack -----
          {
            if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
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
                actCheck=10
                currentAtk=2
              }
              else //Player is attacking
              {
                actCheck=3
              }
            }
          }
          else if atkNum=1 //----- Second attack -----
          {
            if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                actCheck=10
                currentAtk=1
              }
              else //Player is attacking
              {
                actCheck=1
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
          else if atkNum>=1 //----- 3rd and 4th attack -----
          {
            if point_distance(x,0,oPlayer1.x,0)<80 //-- Player is close --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                bFastAtk=1
                actCheck=1
              }
              else //Player is attacking
              {
                actCheck=10
                currentAtk=1
              }
            }
            else //-- Player is far --
            {
              if oPlayer1.attackState=0 //Player is not attacking
              {
                altAtk=2
                actCheck=1
              }
              else //Player is attacking
              {
                altAtk=1
                actCheck=3
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
            yVel=-9
            sprite_index=sSeph_Jump
          }
          else if actTime>=10
          {
            actTime=0
            actCheck=10
            if altAtk=0 {currentAtk=3}
            else {actCheck=3}
          }
        }
        else if actCheck=2 //---------- Dash back ----------
        {
          actTime+=1*gDeltaTime
          if actTime=1
          {
            xVel=4*-image_xscale
            sprite_index=sSeph_DashBack
            if bFastAtk=1 {actTime=4}
          }
          else if actTime>=10
          {
            xVel=0
            actTime=0
            actCheck=10
            currentAtk=1
          }
        }
        else if actCheck=3 //---------- Teleport ----------
        {
          actTime+=1*gDeltaTime
          if actTime=1
          {
            sprite_index=sSeph_Teleport
            bCanTakeDamage=false
            image_alpha-=0.25*gDeltaTime
          }
          //else if actTime>=2 and actTime<=4 {image_alpha-=0.25*gDeltaTime}
          else if actTime>0 and actTime<=4 {image_alpha-=0.25*gDeltaTime} //60fps change: the fade covers every frame of ticks 1-4 ("actTime=1" above is only one frame at 120fps), so Sephiroth fully disappears; it only faded to alpha 0.375 at 120fps
          else if actTime=8
          {
            if altAtk<=1 {x=oPlayer1.x+(48*-oPlayer1.image_xscale)}
            else {x=oPlayer1.x+(48*oPlayer1.image_xscale)}
            if x>oPlayer1.x {image_xscale=-1}
            else {image_xscale=1}
            if x>xCenter+roomSpan-24 {x=xCenter+roomSpan-24}
            if x<xCenter-roomSpan+24 {x=xCenter-roomSpan+24}
          }
          //else if actTime>=9 and actTime<=11 {image_alpha+=0.25*gDeltaTime}
          else if actTime>8 and actTime<12 {image_alpha+=0.25*gDeltaTime} //60fps change: covers every frame of ticks 9-12 except the "actTime=12" frame below, which adds the rest
          else if actTime=12
          {
            image_alpha+=0.25*gDeltaTime
            sprite_index=sSeph_Idle
            bCanTakeDamage=true
            if bFaster=1 {actTime=13}
          }
          else if actTime>=15
          {
            actTime=0
            bFastAtk=1
            actCheck=10
            if altAtk=0 {currentAtk=0}
            else if altAtk=1 {currentAtk=1}
            else if altAtk=2 {currentAtk=3}
          }
        }
        else if actCheck=10 //---------- Execute action ----------
        {
          event_user(currentAtk)
        }
      }
    }
    else //---------- Meteor attack ----------
    {
      actTime+=1*gDeltaTime
      if actTime=1
      {
        if hasArmor = 1
{
    armor=3
    spawnArmorEffect()
}
        sprite_index=sSeph_Summon
        image_index=0
        yVel=0
        bCanTakeDamage=false
        image_alpha-=0.25*gDeltaTime
      }
      //else if actTime>=2 and actTime<=4 {image_alpha-=0.25*gDeltaTime}
      else if actTime>0 and actTime<=4 {image_alpha-=0.25*gDeltaTime} //60fps change: covers every frame of ticks 1-4 (see the teleport), so Sephiroth fully disappears before moving up
      else if actTime=6
      {
        xSpot=x
        x=xCenter
        y=yGround-160
      }
      //else if actTime>=7 and actTime<=10 {image_alpha+=0.25*gDeltaTime}
      else if actTime>6 and actTime<=10 {image_alpha+=0.25*gDeltaTime} //60fps change: covers every frame of ticks 7-10
      else if actTime=12 {bCanTakeDamage=true; image_index=1}
      else if actTime=14 {image_index=2}
      else if actTime=16 {image_index=3}
      else if actTime=18 {image_index=4}
      else if actTime=20 {image_index=5}
      else if actTime=28 {image_index=2}
      else if actTime=30
      {
        var newMeteor;
        newMeteor=instance_create(0,0,oSephMetControl)
        newMeteor.meteorFreq=meteorFreq; newMeteor.meteorTime=meteorTime
      }
      //else if actTime>=67 and actTime<=70 {bCanTakeDamage=false; image_index=0; image_alpha-=0.25*gDeltaTime}
      else if actTime>66 and actTime<=70 {bCanTakeDamage=false; image_index=0; image_alpha-=0.25*gDeltaTime} //60fps change: covers every frame of ticks 67-70
      else if actTime=74
      {
        x=xSpot
        y=yGround
      }
      //else if actTime>=75 and actTime<=77 {image_alpha+=0.25*gDeltaTime}
      else if actTime>74 and actTime<78 {image_alpha+=0.25*gDeltaTime} //60fps change: covers every frame of ticks 75-78 except the "actTime=78" frame below, which adds the rest
      else if actTime=78
      {
        bCanTakeDamage=true
        image_alpha+=0.25*gDeltaTime
      }
      else if actTime>=82
      {
        actTime=0
        sprite_index=sSeph_Idle
        meteor=0
      }
    }

    if meteor<metStormFreq {yVel=scrGravAcc(yVel,0.4,1)}
    if isCollisionBottom(1)
    {
      if currentAtk=3 and yVel>6 {xVel=0; actTime=100}
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

    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.83 and lifePercent>=0.66 and bossProgress=0
    {
      waitDelay-=4
      atkMax+=1
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      resType[1]=2
      resType[5]=2
      bossProgress+=1
    }
    else if lifePercent<=0.65 and lifePercent>=0.51 and bossProgress=1
    {
      waitDelay-=4
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      resType[1]=1
      resType[3]=2
      resType[5]=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.31 and bossProgress=2
    {
      waitDelay-=4
      atkMax+=1
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      resType[3]=1
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0 and bossProgress=3
    {
      waitDelay-=4
      meteorTime+=5
      meteorFreq-=1
      if meteor>=metStormFreq {meteor+=1}
      metStormFreq+=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oSephAtk {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
      if global.levelTimeSecond<=35 and oPlayer1.tookHitAmount=0
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,9)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Swordswoman"; tAchievement.checkNum=9
        }
      }
    }
    //else if deathAnim>=2 and deathAnim<=75
    else if deathAnim>1 and deathAnim<=75 //60fps change: includes every frame of tick 2, not just its last one
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
    else if deathAnim>=80
    {
      if global.bBossGallery=1
      {
        bossRoomTally(46)
        global.newMapX=1736; global.newMapY=464; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}

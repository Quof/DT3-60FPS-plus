if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0

    for(i=0;i<80;i+=1)
    {
      var tEffect;
      tEffect=instance_create(x-random(105),y-random(105),oEffect)
      tEffect.sprite_index=sDeathFlameA
      tEffect.image_speed=0.2+random(0.2)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    with oEnemyBase
    {
      atkPower=6
      jeremyText=oBlackmoorMain.jeremyText
      chaoText=oBlackmoorMain.chaoText
      devText=oBlackmoorMain.devText
      var myShadow;
      myShadow=instance_create(0,0,oObjectShadow)
      myShadow.ownerID=id; myShadow.type=3; myShadow.maxShadowDist=192
    }
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //Erratic movement
    if bErratic=1
    {
      if bendProg=0
      {
        bendSpd-=0.05*gDeltaTime
        if bendSpd<=-0.5 {bendProg=1}
      }
      else if bendProg=1
      {
        bendSpd+=0.05*gDeltaTime
        if bendSpd>=0.5 {bendProg=0}
      }
      image_angle+=bendSpd*gDeltaTime
      bodyMove+=1*gDeltaTime
    }
    for(i=0;i<2;i+=1) {fingerMove[i]+=(0.8+(i*0.2))*gDeltaTime}

    if despProg<=1
    {
      //-------------------- NORMAL MOVEMENT PATTERN --------------------
      moveTime+=1*gDeltaTime
      if moveCycle=0 //Stationary, then V-shape
      {
        //if moveTime>=241 and moveTime<=300 {y-=0.25*gDeltaTime}
        if moveTime>240 and moveTime<=300 {y-=0.25*gDeltaTime} //60fps change: windows include every frame of their first tick; with >= each lost 3/4 of a tick at 120fps, so the rise and the V didn't cancel and the body crept upward
        //else if moveTime>=301 and moveTime<=330 {x+=0.25*gDeltaTime; y+=0.25*gDeltaTime}
        else if moveTime>300 and moveTime<=330 {x+=0.25*gDeltaTime; y+=0.25*gDeltaTime} //60fps change: see above
        //else if moveTime>=331 and moveTime<=360
        else if moveTime>330 and moveTime<=360 //60fps change: see above
        {
          x-=0.25*gDeltaTime; y+=0.25*gDeltaTime
          if moveTime=360 {moveTime=0; moveCycle+=1}
        }
      }
      else if moveCycle=1 //Go to back of room, then back to mid
      {
        if moveTime=210 or moveTime=270 or moveTime=330 {instance_create(x,despY1,oBlackmoorSword)}

        //if moveTime>=201 and moveTime<=220
        if moveTime>200 and moveTime<=220 //60fps change: includes every frame of tick 201, so the dash covers the full 80px (77px at 120fps)
        {
          if moveTime=201
          {
            playSound(global.snd_ChargeStrike,0,0.92,19000)
            var tEffect;
            tEffect=instance_create(x-48,y-32,oEffect)
            tEffect.sprite_index=sGroundBlast; tEffect.image_angle=90; tEffect.image_blend=c_black; tEffect.image_speed=0.5
            if hasArmor = 1 and armor < 3
            {
                armor=3
                spawnArmorEffect()
            }
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          x+=4*gDeltaTime
        }
        else if moveTime=401 {warnCircle=80}
        //else if moveTime>=431 and moveTime<=450
        else if moveTime>430 and moveTime<=450 //60fps change: same for the dash back
        {
          if moveTime=431
          {
            playSound(global.snd_ChargeStrike,0,0.92,19000)
            var tEffect;
            tEffect=instance_create(x,y-32,oEffect)
            tEffect.sprite_index=sGroundBlast; tEffect.image_angle=270; tEffect.image_blend=c_black; tEffect.image_speed=0.5
            if hasArmor = 1 and armor < 3
            {
                armor=3
                spawnArmorEffect()
            }
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          x-=4*gDeltaTime
          if moveTime=450 {moveTime=0; moveCycle+=1}
        }
      }
      else if moveCycle=2 //Circle in place
      {
        if moveTime>=201
        {
          _speed=0.25
          _direction=moveDir
          moveDir+=2*gDeltaTime
          if moveDir=180 {_speed=0; moveDir=0; moveTime=0; moveCycle=0}
        }
      }

      //-------------------- ATTACK: DOUBLE ARM SWING --------------------
      dArmSwingTime+=1*gDeltaTime
      if dArmSwingTime>=dArmSwingDelay and dArmSwingTime<=dArmSwingDelay+100 //Check distance to player
      {
        if point_distance(x,y,oPlayer1.x,oPlayer1.y)<208 and armMeteorTime<armMeteorDelay {dArmSwingTime=10000}
        else {dArmSwingTime=dArmSwingDelay-10}
      }
      else if dArmSwingTime>=10000
      {
        event_user(0)
      }

      //-------------------- ATTACK: METEOR SUMMON (With arms) --------------------
      armMeteorTime+=1*gDeltaTime
      if armMeteorTime>=armMeteorDelay and armMeteorTime<=armMeteorDelay+100
      {
        if dArmSwingTime<dArmSwingDelay-45 {armMeteorTime=10000}
        else {armMeteorTime=armMeteorDelay-55}
      }
      else if armMeteorTime>=10000
      {
        event_user(1)
      }

      //-------------------- ATTACK: METEOR SUMMON FALL --------------------
      fallMeteorTime+=1*gDeltaTime
      if fallMeteorTime>=fallMeteorDelay and fallMeteorTime<=fallMeteorDelay+100
      {
        if armMeteorTime<armMeteorDelay-20 {fallMeteorTime=10000}
        else {fallMeteorTime=fallMeteorDelay-30}
      }
      else if fallMeteorTime=10001
      {
        var newMeteor;
        for(i=0;i<7;i+=1)
        {
          newMeteor=instance_create((xCenter-roomSpan)+(i*72),-24-(i*48),oBlackmoorMeteor)
          newMeteor.atkPower=atkPower; newMeteor.bulletSpeed=8+(i/10); newMeteor._direction=270
        }
      }
      else if fallMeteorTime=10061
      {
        var newMeteor;
        for(i=0;i<7;i+=1)
        {
          newMeteor=instance_create((xCenter+roomSpan)-(i*72),-24-(i*48),oBlackmoorMeteor)
          newMeteor.atkPower=atkPower; newMeteor.bulletSpeed=8+(i/10); newMeteor._direction=270
        }
      }
      else if fallMeteorTime=10080 {fallMeteorTime=0}
    }

    if posCheck=0 and y<216 {posCheck=32}
    if posCheck>0
    {
      if gDeltaDoTicks y+=1
      posCheck-=1*gDeltaTime
    }

    //Desperation Attack
    if despProg>=1 {event_user(2)}

    //-------------------- UTILITY: FLAME MOVE --------------------
    if flameProg=1
    {
      //if gDeltaDoTicks oGateCFlame.x+=0.25
      if !variable_local_exists("flameSlide") {flameSlide=0}
      if gDeltaDoTicks {flameSlide+=0.25; if flameSlide>=1 {oGateCFlame.x+=1; flameSlide-=1}} //60fps change: the same speed in whole pixels (it moved a fraction of one per tick and sat between pixels, which drew unevenly)
      flameMove+=1*gDeltaTime
      if flameMove=32 {flameMove=0; flameProg=0}
    }

    //-------------------- UTILITY: ADVANCING WALL --------------------
    if advancingWall>=1 and advancingWall<9000
    {
      advancingWall+=1
      if advancingWall=2 {instance_create(256,112,oBlackmoorDeathWall)}
      oBlackmoorDeathWall.x+=1*gDeltaTime
      if oBlackmoorDeathWall.x>=352 {advancingWall=10000}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.88 and lifePercent>=0.76 and bossProgress=0
    {
      dArmSwingDelay-=5
      fallMeteorDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.75 and lifePercent>=0.63 and bossProgress=1
    {
      flameProg=1
      meteorAmt+=1
      dArmSwingDelay-=5
      bossProgress+=1
    }
    else if lifePercent<=0.62 and lifePercent>=0.51 and bossProgress=2
    {
      armMeteorDelay-=10
      fallMeteorDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.50 and lifePercent>=0.38 and bossProgress=3
    {
      dArmSwingDelay-=5
      fallMeteorDelay-=10
      advancingWall=1
      bossProgress+=1
    }
    else if lifePercent<=0.37 and lifePercent>=0.26 and bossProgress=4
    {
      flameProg=1
      meteorAmt+=1
      armMeteorDelay-=10
      //despProg=1
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0.13 and bossProgress=5
    {
      dArmSwingDelay-=5
      fallMeteorDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.12 and lifePercent>=0 and bossProgress=6
    {
      meteorAmt+=1
      armMeteorDelay-=10
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    if deathAnim == 0 {deathAnim = 1-gDeltaTime}; deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      _speed=0
      with oObjectShadow {instance_destroy()}
      with oBlackmoorMeteor {instance_destroy()}
      with oBlackmoorShadowExp {instance_destroy()}
      with oBlackmoorFlame {instance_destroy()}
      with oBlackmoorDeathWall {instance_destroy()}
      with oBlackmoorSword {instance_destroy()}
      with oEnemyBase {bCanDealDamage=false}
    }
    //else if deathAnim>=2 and deathAnim<=55
    else if deathAnim>1 and deathAnim<=55 //60fps change: includes every frame of tick 2, not just its last one
    {
      if oGame.time mod (2/gDeltaTime)=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(15)
        global.newMapX=2904; global.newMapY=1024; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        with oEnemyBase {instance_destroy()}
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
else {_speed=0}

correctSpeedDirection(self)

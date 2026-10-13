if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //----- Movement -----
    if x<oPlayer1.x {image_xscale=1} else {image_xscale=-1}

    moveTime+=1*gDeltaTime
    if moveTime>=moveDelay
    {
      x=round(x); y=round(y)
      shiftAtk=0
      moveType+=1
      if moveType=4 {moveType=0}
      moveSpd=0
      moveTime=0
    }

    if moveType=0 //Glide to player x
    {
      if gDeltaDoTicks and y>moveYcenter {y-=1}
      else if gDeltaDoTicks and  y<moveYcenter {y+=1}

      if x>oPlayer1.x {if moveSpd>-3 {moveSpd-=0.15*gDeltaTime}}
      else if x<oPlayer1.x {if moveSpd<3 {moveSpd+=0.15*gDeltaTime}}
      x+=moveSpd*gDeltaTime
    }
    else if moveType=1 //Move down in player's way
    {
      if gDeltaDoTicks and y<moveYcenter+80 {y+=1}
    }
    else if moveType=2 //Move to top corner
    {
      //if moveTime>=1 and moveTime<=20 and moveTime mod 2=0
      //60fps change: for the first 20 ticks the 30fps code leaves an afterimage on even ticks and moves only on odd ticks. Above
      //30fps, moveTime is only whole on one frame per tick, so it moved on 7 of every 8 frames and reached the corner ~8 ticks
      //early (the spread shots then came from a different spot). Now the whole even tick is skipped (ceil gives the tick
      //number), with the afterimage on its whole-number frame as before.
      if moveTime>0 and moveTime<=20 and ceil(moveTime) mod 2=0
      {
        if frac(moveTime)=0 //60fps change (added)
        {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_green
        tAfterI.image_alpha=0.75; tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
        tAfterI.imageFade=0.05; tAfterI.xScaling=0.2; tAfterI.yScaling=0.2; tAfterI.bFollow=0
        } //60fps change (added)
      }
      else
      {
        if xPrev!=x and yPrev!=y and gDeltaDoTicks //(once per 30fps tick, not every frame)
        {
          var tAfterI;
          tAfterI=instance_create(x,y,oEnemyAfterImage)
          tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_green
          tAfterI.image_alpha=0.8; tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
          tAfterI.imageFade=0.1; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
        }
        
        xPrev=x; yPrev=y
        if x>=xCenter
        {
          if x<xCenter+roomSpan {x+=6*gDeltaTime}
        }
        else if x<xCenter
        {
          if x>xCenter-roomSpan {x-=6*gDeltaTime}
        }
        if y>moveYcenter-64 {y-=6*gDeltaTime}
      }
    }
    else if moveType=3 //Move under platform
    {
      if moveTime>=1 and moveTime<=20 and moveTime mod 2=0
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_green
        tAfterI.image_alpha=0.5; tAfterI.image_xscale=image_xscale*1.5; tAfterI.image_yscale=1.5; tAfterI.xShift=0; tAfterI.yShift=0
        tAfterI.imageFade=0.05; tAfterI.xScaling=-0.1; tAfterI.yScaling=-0.1; tAfterI.bFollow=0
      }
      //else if moveTime>=21
      else if moveTime>20 //60fps change: includes every frame of tick 21
      {
        if y<yGround+96 {y+=4*gDeltaTime}
      }
    }
    
    //-------------------- ATTACK: TRACKING FIREBALLS --------------------
    trackFireTime+=1*gDeltaTime
    if trackFireTime>=trackFireDelay and trackFireTime<=trackFireDelay+100
    {
      resType[3]=4
      image_speed=0; trackFireTime=10000
    }
    else if trackFireTime>=10020 and trackFireTime mod 12=0
    {
      var tTrackFire;
      tTrackFire=instance_create(x+(11*image_xscale),y-52,oVaultD_Fireball)
      tTrackFire.atkPower=atkPower; tTrackFire.trackTime=50+(trFiCur*fireOffset)
      tTrackFire.image_blend=make_color_rgb(16,98,240)
      
      trFiCur+=1
      if trFiCur>=trackFireMax
      {
        resType[3]=3
        image_speed=0.25; trFiCur=0; trackFireTime=0
      }
    }
    
    //-------------------- ATTACK: MOVE SHIFT ATTACK --------------------
    shiftAtk+=1*gDeltaTime
    if moveType=0 //----- Rain fireball slowly on sides -----
    {
      if shiftAtk=10
      {
        var tAtk;
        tAtk=instance_create(xCenter-roomSpan+32,112,oPassBullet)
        tAtk.sprite_index=sDraculaMeteor; tAtk._direction=270; tAtk.image_xscale=2; tAtk.image_yscale=2
        tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
        tAtk=instance_create(xCenter+roomSpan-32,112,oPassBullet)
        tAtk.sprite_index=sDraculaMeteor; tAtk._direction=270; tAtk.image_xscale=2; tAtk.image_yscale=2
        tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
        if bossProgress>=3
        {
          tAtk=instance_create(xCenter-roomSpan+32,48,oPassBullet)
          tAtk.sprite_index=sDraculaMeteor; tAtk._direction=270; tAtk.image_xscale=2; tAtk.image_yscale=2
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
          tAtk=instance_create(xCenter+roomSpan-32,48,oPassBullet)
          tAtk.sprite_index=sDraculaMeteor; tAtk._direction=270; tAtk.image_xscale=2; tAtk.image_yscale=2
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
        }
      }
    }
    else if moveType=1 //----- Lightning Rain (Static position) -----
    {
      if shiftAtk=10 //Warn start
      {
        shiftTempA=8
        shiftTempB=xCenter-roomSpan
        shiftTempC=1
      }
      else if shiftAtk=41 //Attack
      {
        var tAtk;
        for(i=0;i<shiftTempA;i+=1)
        {
          tAtk=instance_create(shiftTempB+(i*48),yGround+32,oDamageExplosion)
          tAtk.atkPower=atkPower; tAtk.sprite_index=sDraculaLightning; tAtk.decayTime=-100; tAtk.image_speed=0.25
          tAtk.image_xscale=7; tAtk.image_angle=90
          tAtk=instance_create(shiftTempB+(i*48),yGround-112,oDamageExplosion)
          tAtk.atkPower=atkPower; tAtk.sprite_index=sDraculaLightning; tAtk.decayTime=-100; tAtk.image_speed=0.25
          tAtk.image_xscale=3.5; tAtk.image_angle=90
        }
      }
      if bossProgress>=3
      {
        if shiftAtk=50 //Warn start
        {
          shiftTempA=7
          shiftTempB=xCenter-roomSpan+24
          shiftTempC=1
        }
        else if shiftAtk=81 //Attack
        {
          var tAtk;
          for(i=0;i<shiftTempA;i+=1)
          {
            tAtk=instance_create(shiftTempB+(i*48),yGround+32,oDamageExplosion)
            tAtk.atkPower=atkPower; tAtk.sprite_index=sDraculaLightning; tAtk.decayTime=-100; tAtk.image_speed=0.25
            tAtk.image_xscale=7; tAtk.image_angle=90
            tAtk=instance_create(shiftTempB+(i*48),yGround-112,oDamageExplosion)
            tAtk.atkPower=atkPower; tAtk.sprite_index=sDraculaLightning; tAtk.decayTime=-100; tAtk.image_speed=0.25
            tAtk.image_xscale=3.5; tAtk.image_angle=90
          }
        }
      }
    }
    else if moveType=2 //----- Lightning Spread Shot -----
    {
      if shiftAtk=1
      {
        if bossProgress<=2
        {
          shiftTempA=80
          shiftTempB=20
        }
        else
        {
          shiftTempA=115
          shiftTempB=15
        }
      }
      if shiftAtk>=31 and shiftAtk<=shiftTempA and shiftAtk mod shiftTempB=0
      {
        var tAtk,tAtkDir;
        tAtkDir=point_direction(x+(21*image_xscale),y-52,oPlayer1.x,returnPlayerYCenter())
        tAtkDir-=10
        for(i=0;i<3;i+=1)
        {
          tAtk=instance_create(x+(21*image_xscale),y-52,oPassBullet)
          tAtk.sprite_index=sDraculaLightning
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=4.5; tAtk.decayTime=-100
          tAtk._direction=tAtkDir
          tAtkDir+=10
        }
      }
    }
    else if moveType=3 //----- Fire off fireballs across field -----
    {
      if shiftAtk=1
      {
        if bossProgress<=2 {shiftTempA=10}
        else {shiftTempA=8}
      }
      else if shiftAtk>=10 and shiftAtk<=100 and shiftAtk mod shiftTempA=0
      {
        var tAtk,tAtkDir;
        if x<xCenter {tAtkDir=0} else {tAtkDir=180}
        tAtk=instance_create(x+(21*image_xscale),y-52,oPassBullet)
        tAtk.sprite_index=sDraculaMeteor; tAtk._direction=tAtkDir; tAtk.image_xscale=0.5; tAtk.image_yscale=0.5
        tAtk.atkPower=atkPower; tAtk.bulletSpeed=4.5; tAtk.decayTime=-100
      }
    }
    
    //-------------------- UTILITY: LAVABALL --------------------
    if !instance_exists (oVaultLavaball) {lavaballTime+=1*gDeltaTime}
    if lavaballTime>=lavaballDelay and lavaballTime<=lavaballDelay+100 {lavaballTime=10000}
    else if lavaballTime>=10001
    {
      if hasArmor = 1
{
    armor=3
    spawnArmorEffect()
}
      resType[0]=3
      if bossProgress<=1 {resType[1]=4}
      else {resType[1]=3}
      instance_create(x+(11*image_xscale),256,oVaultLavaball)
      lavaballTime=0
    }
  }
  
  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
  {
    trackFireDelay-=5
    trackFireMax+=1
    fireOffset-=4
    lavaballDelay-=20
    bossProgress+=1
  }
  else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
  {
    trackFireDelay-=10
    trackFireMax+=1
    fireOffset-=4
    lavaballDelay-=20
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
    resType[1]-=1
    bossProgress+=1
  }
  else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
  {
    trackFireDelay-=5
    trackFireMax+=1
    fireOffset-=4
    lavaballDelay-=20
    bossProgress+=1
  }
  else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=3
  {
    trackFireDelay-=10
    trackFireMax+=1
    fireOffset-=4
    lavaballDelay-=20
    bossProgress+=1
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1*gDeltaTime
  if deathAnim=1
  {
    if global.bBossGallery=1
    {
      bossRoomTally(29)
      global.newMapX=648; global.newMapY=848; room_goto(rBossGallery)
    }
    else
    {
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
      with oVaultLavaball {instance_destroy()}
      with (oMarioLava) {instance_destroy()}
      with (oDesertWaterVol) {instance_destroy()}
      shiftAtk=0
      var tWater;
      tWater=instance_create(2176,352,oDesertWaterVol)
      tWater.image_xscale=64; tWater.image_yscale=24
      tWater=instance_create(64,384,oDesertWaterVol)
      tWater.image_xscale=64; tWater.image_yscale=24
      
      global.gamePaused=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.visible=0; oPlayer1.x=2208; oPlayer1.y=384
      x=2208; y=288
      
      mashingButtons=instance_create(0,0,oMashButtons)
      mashingButtons.xCenter=2208; mashingButtons.yCenter=304
      mashingButtons.startJerryX=2320; mashingButtons.startJerryY=320
      mashingButtons.startClaireX=2096; mashingButtons.startClaireY=320
    }
  }
  else if deathAnim=15
  {
    msgCreate(0,0,"Jerry","FINISH HIM!!",0,0,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if deathAnim=70
  {
    msgCreate(0,0,"Claire","You going to do that every time?",0,1,oMessagePerson,0)
    newMessage.fadingTime=90
  }
  else if deathAnim=165
  {
    mashingButtons.bCanHit=1
  }
  else if deathAnim>=175 and deathAnim<=185
  {
    if deathAnim=180 {deathAnim=175}
    
    if mashingButtons.timeToStop<=0
    {
      global.gamePaused=false
      mashingButtons.bCanHit=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.visible=1
      deathAnim=195
    }
  }
  //else if deathAnim>=196 and deathAnim<=255
  else if deathAnim>195 and deathAnim<=255 //60fps change: includes every frame of tick 196, not just its last one
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod (2/gDeltaTime)=0
    {
      var tEffect;
      tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>=256
  {
    oEvCh12MainA.sceneProgress=1
    instance_destroy()
  }
}

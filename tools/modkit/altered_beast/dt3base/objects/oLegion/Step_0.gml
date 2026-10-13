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
    bCanDealDamage=true
    //-- Spear Data --
    var tSetDir; tSetDir=0
    for(i=0;i<12;i+=1)
    {
      newSpear[i]=instance_create(x,y,oLegionSpear)
      newSpear[i].baseDir=tSetDir
      newSpear[i].stabTime=i*30
      tSetDir+=360/12
    }
    image_xscale=1.5
    image_yscale=1.5
  }

  if bActive=true and life>0
  {
    //---------- MOVEMENT ----------
    if moveCycle=0 //Right
    {
      x+=moveSpd*gDeltaTime
      if x>=(xCenter+roomSpan)-(sprite_width/2)-16 {moveCycle=1}
    }
    else if moveCycle=1 //Left
    {
      x-=moveSpd*gDeltaTime
      if x<=(xCenter-roomSpan)+(sprite_width/2)+16 {moveCycle=0}
    }
    stepCount+=(pi/60)*gDeltaTime
    y+=sin(stepCount)*gDeltaTime

    efFlyTime+=1*gDeltaTime
    if efFlyTime mod 3=0
    {
      var tEffect,tEfDist,tEfDir;
      tEfDist=random(56)*image_xscale
      tEfDir=random(360)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sLegionFly; tEffect.x=x+lengthdir_x(tEfDist,tEfDir); tEffect.y=y+lengthdir_y(tEfDist,tEfDir)
      tEffect.image_speed=0.5; tEffect.decay=6+irandom(4)
      tEffect.xSpd=(2+random(1))*choose(-1,1); tEffect.ySpd=(2+random(1))*choose(-1,1)
      tEffect.newBlend=-1; tEffect.followID=-1
    }

    //---------- ATTACK: SCYTHE CIRCLE ----------
    scytheCircleTime+=1*gDeltaTime
    if scytheCircleTime>=scytheCircleDelay
    {
      playSound(global.snd_OrbThrow,0,0.97,20000)
      var tAtkScythe,tAtkDir,tAtkSpawnDir;
      tAtkDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
      tAtkSpawnDir=0
      for(i=0;i<16;i+=1)
      {
        tAtkScythe=instance_create(x,y,oDeathFlyingScythe)
        tAtkScythe.x=x+lengthdir_x(80,tAtkSpawnDir); tAtkScythe.y=y+lengthdir_y(80,tAtkSpawnDir)
        tAtkScythe.atkPower=atkPower; tAtkScythe.bulletSpeed=5; tAtkScythe._direction=tAtkDir
        tAtkSpawnDir+=360/16
      }
      scytheCircleTime=0
    }

    //---------- ATTACK: BIG SCYTHE ----------
    bigScytheTime+=1*gDeltaTime
    if bigScytheTime>=bigScytheDelay
    {
      playSound(global.snd_DeathSlash,0,0.97,14000)
      var tAtkScythe;
      if bigScytheProg<3
      {
        tAtkScythe=instance_create(160+(144*bigScytheProg),48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe._direction=270
      }
      else if bigScytheProg=3
      {
        tAtkScythe=instance_create(232,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe._direction=270
        tAtkScythe=instance_create(376,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe._direction=270
      }
      else if bigScytheProg=4
      {
        tAtkScythe=instance_create(32,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe._direction=270
        tAtkScythe=instance_create(96,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe._direction=270
        tAtkScythe=instance_create(512,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe._direction=270
        tAtkScythe=instance_create(576,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe._direction=270
      }

      bigScytheProg+=1
      if bigScytheProg=5 {bigScytheProg=0}
      bigScytheTime=0
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=3
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    image_xscale=0.5+lifePercent
    image_yscale=0.5+lifePercent
  }
  else if life<=0 //Defeat animations
  {
    if deathAnim == 0 {deathAnim = 1-gDeltaTime}; deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
    }
    //else if deathAnim>=2 and deathAnim<=55
    else if deathAnim>1 and deathAnim<=55 //60fps change: includes every frame of tick 2, not just its last one
    {
      if oGame.time mod (2/gDeltaTime)=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5
        tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(14)
        global.newMapX=2856; global.newMapY=1312; room_goto(rBossGallery)
      }
      else
      {
        oEvCh6MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}

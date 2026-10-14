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
    if hitcount>=5
    {
        if oPlayer1.attackState=43 // = ACT_MORPHBALL
        {
          with oPlayer1 //unmorph
          {
            setCollisionBounds(-7,-39,7,-1)
            //setCollisionBounds(-8,-39,8,-1)
            //if isCollisionLeft(0)=1 {x+=1}
            //if isCollisionRight(0)=1 {x-=1}
            if global.location=106 or room=rReckoningOne or room=rReckoningTwo or global.modeNice=1 {runAcc=0.8}     //spsp
            else {runAcc=7.3}
            SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
            attackState=0
          }
        }
        charSwitcher(1-global.activeCharacter)
        hitcount=0
    } //spsp ns
    
    //-------------------- MOVEMENT --------------------
    if goDown=0 //Up
    {
      if ySpd>-0.4 {ySpd=scrGravAcc(ySpd,-0.01,1)}
      if y<=96 {goDown=1}
    }
    else //Down
    {
      if ySpd<0.4 {ySpd=scrGravAcc(ySpd,0.01,1)}
      if y>=192 {goDown=0}
    }
    if x>oPlayer1.x
    {
      if xSpd>-1.5 {xSpd-=0.01*gDeltaTime}
    }
    else
    {
      if xSpd<1.5 {xSpd+=0.01*gDeltaTime}
    }

    x+=xSpd*gDeltaTime; {y+=ySpd*gDeltaTime}
    
    //-------------------- ATTACK: STREAM -------------------------- //spsp ns
    /*streamTime+=1
    if streamTime>=streamDelay
    {
        var tAtk;
        tAtk=instance_create(x,y,oDefProjA)
        tAtk.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        tAtk.type=0
        tAtk.bulletProg=2
        streamTime=0
    }*/

    //-------------------- ATTACK: RING BULLETS --------------------
    ringBulletTime+=1*gDeltaTime
    if ringBulletTime>=ringBulletDelay
    {
      var tAtk,tDir,tType;
      tDir=0
      tType=0
      if ringBulletAmt mod 2=0 {tType=1}
      for(i=0;i<20;i+=1)
      {
        tAtk=instance_create(x,y,oDefProjA)
        tAtk._direction=tDir; tAtk.type=tType
        tDir+=360/20
      }
      ringBulletAmt+=1
      if ringBulletAmt>=ringBulletMax
      {
        //Cycle through resists
        resistChange+=1
        if resistChange=6 {resistChange=0}
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        resType[resistChange]=3

        ringBulletAmt=0
        ringBulletTime=0
      }
      else {ringBulletTime=ringBulletDelay-20}
    }

    //-------------------- ATTACK: SKY LIGHTNING --------------------
    lightningTime+=1*gDeltaTime
    if lightningTime>=lightningDelay
    {
      var tAtk,;
      tAtk=instance_create(oPlayer1.x,0,oDefLightning)
      lightningAmt+=1
      if lightningAmt>=lightningMax
      {
        lightningAmt=0
        lightningTime=0
      }
      else {lightningTime=lightningDelay-25}
    }
    //-------------------- SPIKE WALLS --------------------
    if spikeProg=1
    {
      mySpikeA=instance_create(320,0,oDefSpike); mySpikeA.movement=272
      mySpikeB=instance_create(1408,0,oDefSpike); mySpikeB.movement=272; mySpikeB.image_xscale=-1
      spikeProg=2
    }

    //-------------------- INSULTS --------------------
    insultTime+=1*gDeltaTime
    if insultTime>=insultDelay and insultTime<=insultDelay+100
    {
      image_speed=0; insultTime=10000
    }
    else if insultTime=10001 //Insult player
    {
      var tMessage;
      tMessage=""
      if false  //spsp
      {
      if insultNum=0 {tMessage="You are worthless..."}
      else if insultNum=1 {tMessage="Pathetic..."}
      else if insultNum=2 {tMessage="Incompetent."}
      else if insultNum=3 {tMessage="You can't help anyone."}
      else if insultNum=4 {tMessage="You let them down."}
      else if insultNum=5 {tMessage="You are a failure."}
      }
      else
      {
          if insultNum=0 {tMessage="You signed up for this."}
          else if insultNum=1 {tMessage="This is your fault."}
          else if insultNum=2 {tMessage="Stop attacking please."}
          else if insultNum=3 {tMessage="Thank you."}
          else if insultNum=4 {tMessage="So how's the weather?"}
          else if insultNum=5 {tMessage="Will I be in DT4?"}
          else if insultNum=6 {tMessage="You haven't won yet?"}
          else if insultNum=7 {tMessage="Neil must be crying."}
      }
      msgCreate(200,48,"Defective",tMessage,7,0,oMessagePerson,0)
      newMessage.fadingTime=90
      insultNum+=1
      if insultNum=6 and false {insultNum=0}    //spsp
      else if insultNum=8 {insultNum=0}
      global.bSoundCanPlay=0
      for(i=0;i<5;i+=1)
      {
        if global.hasAbilToken[i]>=2 {global.hasAbilToken[i]=1}
      }
      pastAbilityA=global.activeAbility[0]
      pastAbilityB=global.activeAbility[1]
      global.activeAbility[0]=0
      global.activeAbility[1]=0
    }
    else if insultTime=10090 //Reset sound volume
    {
      global.bSoundCanPlay=1
      abilSetRemove(0)
      global.activeAbility[0]=pastAbilityA
      global.activeAbility[1]=pastAbilityB
      insultTime=0
    }
  }
  enemyStepEvent()

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.9 and lifePercent>=0.71 and bossProgress=0
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    spikeProg=1
    bossProgress+=1
  }
  else if lifePercent<=0.7 and lifePercent>=0.56 and bossProgress=1
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    mySpikeA.movement+=32; mySpikeB.movement+=32
    bossProgress+=1
  }
  else if lifePercent<=0.55 and lifePercent>=0.39 and bossProgress=2
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    lightningMax+=1
    mySpikeA.movement+=32; mySpikeB.movement+=32
    bossProgress+=1
  }
  else if lifePercent<=0.38 and lifePercent>=0.2 and bossProgress=3
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    mySpikeA.movement+=32; mySpikeB.movement+=32
    bossProgress+=1
  }
  else if lifePercent<=0.19 and lifePercent>=0 and bossProgress=4
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    mySpikeA.movement+=16; mySpikeB.movement+=16
    bossProgress+=1
  }
}

if life<=0 //Defeat animation
{
  deathAnim+=1*gDeltaTime
  if deathAnim=1
  {
    with oEProjectileBase {instance_destroy()}
    with oMovingSolid {instance_destroy()}
    with oAttackBase {instance_destroy()}
  }
  //else if deathAnim>=2
  else if deathAnim>1 //60fps change: includes every frame of tick 2
  {
    y+=1*gDeltaTime
    image_alpha-=0.02*gDeltaTime
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(53)
        global.newMapX=568; global.newMapY=560; room_goto(rBossGallery)
      }
      else
      {
        oEvCh19MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
}

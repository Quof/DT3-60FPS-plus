if global.gamePaused=false
{
  if activateBoss=1
  {
    global.recBirdsSeen+=1
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if shieldUp=1
    {
        resType[0]=1 //maybe later shields are harsher? (same control var as normal damage)
        resType[1]=2
        resType[2]=2
        resType[4]=4
        resType[5]=2
        sprite_index=sTEXfaceshield
        //collision event for removing shield? (make sure this doesn't remove the "getting damaged" part, or maybe that's fine, too
        //health threshold?
    }
    else if shieldUp>=2
    {
        resType[0]=2-weakcheck
        resType[1]=3
        resType[2]=3
        resType[4]=3
        resType[5]=3
        sprite_index=sThunderbirdFace
        shieldUp=0
    }

    if bFrameUp=0
    {
      animFrame+=0.2*gDeltaTime
      //if animFrame=3.4 {bFrameUp=1}
      if animFrame>=3.4-0.001 {bFrameUp=1} //60fps change: >= since adding 0.2*gDeltaTime may not land exactly on 3.4
    }
    else if bFrameUp=1
    {
      animFrame-=0.2*gDeltaTime
      //if animFrame=0.6 {bFrameUp=0}
      if animFrame<=0.6+0.001 {bFrameUp=0} //60fps change: <= (see above)
    }

    //---------- Movement ----------
    if xSpd>0 and x>=rmBd_Right //Right side
    {
      xSpd*=-1
      if fastMove>=0
      {
        fastMove+=1
        if fastMove>=2 and fastMove<=9
        {
          spdMod=3
          fastMove=10
        }
        else if fastMove>=10
        {
          spdMod=1
          fastMove=0
        }
      }
    }
    else if xSpd<0 and x<=rmBd_Left //Left side
    {
      xSpd*=-1
      if fastMove>=0
      {
        fastMove+=1
        if fastMove>=2 and fastMove<=9
        {
          spdMod=3
          fastMove=10
        }
        else if fastMove>=10
        {
          spdMod=1
          fastMove=0
        }
      }
    }
    if ySpd>0 and y>=rmBd_Bottom //Bottom side
    {
      ySpd*=-1
    }
    else if ySpd<0 and y<=rmBd_Top //Top side
    {
      ySpd*=-1
    }
    x+=xSpd*spdMod*gDeltaTime; y+=ySpd*gDeltaTime

    if spdMod>1
    {
      if oGame.time mod (5/gDeltaTime)=0
      {
        playSound(global.snd_Shock,0,1,44100)
        tNewAttack=instance_create(x,y,oTEXball)
        //tNewAttack.atkPower=atkPower; tNewAttack.direction=90; tNewAttack.fast=3
        tNewAttack.atkPower=atkPower; tNewAttack._direction=90; tNewAttack.fast=3 //60fps change: oTEXball moves by _direction (its Step)
      }
    }

    //---------- Normal Attack: Fireball ----------
    atkTime+=1*gDeltaTime
    if spdMod>1
    {
        //atkTime-=1
        atkTime-=1*gDeltaTime //60fps change: takes back this frame's count (above), so atkTime holds still
        if atkTime mod atkDelay=0 {atkTime-=1}
    }
    if atkTime mod atkDelay=0 //Spew fireballs
    {
      if cycle<boltCycle
    {
      var tNewAttack,tDistCheck;
      tDistCheck=point_distance(x,0,oPlayer1.x,0)/48*atkDir
      if atkDir=1 {atkDir=-1}
      else {atkDir=1}
        playSound(global.snd_LightballSpread,0,0.82,44100)
        tNewAttack=instance_create(x,y-24,oTEXlightning)
        tNewAttack.atkPower=atkPower; tNewAttack.damageType="ELEMENTAL"
        //tNewAttack.hspeed=tDistCheck; tNewAttack.vspeed=-3
        tNewAttack._hspeed=tDistCheck; tNewAttack._vspeed=-3 //60fps change: oTEXlightning moves by _hspeed/_vspeed (its Step)
        tNewAttack.image_xscale=0.7; tNewAttack.image_yscale=0.7
        /*if bossProgress>=4 and cycle=2
        {
            tDistCheck=-point_distance(x,0,oPlayer1.x,0)/48
            tNewAttack=instance_create(x,y,oTEXlightning)
            tNewAttack.atkPower=atkPower; tNewAttack.damageType="ELEMENTAL"
            tNewAttack.hspeed=tDistCheck; tNewAttack.vspeed=-5
            tNewAttack.image_xscale=0.7; tNewAttack.image_yscale=0.7
        }*/
        cycle+=1
      }
      else if cycle>=boltCycle
      {
        var tNewAttack,tDistCheck;
        tDistCheck=intercept_course_player(x,-32,boltSpeed)
        playSound(global.snd_LaserA,0,1,44100)
        tNewAttack=instance_create(x,-32,oTEXzap)
        //tNewAttack.fast=boltSpeed; tNewAttack.direction=tDistCheck
        tNewAttack.fast=boltSpeed; tNewAttack._direction=tDistCheck //60fps change: oTEXzap moves by _direction (its Step)
        tNewAttack.image_angle=tDistCheck
        cycle=0
      }
    }

    if spikeRise=1
    {
        with oHexFullCircle
        {
            //y-=0.5
            y-=0.5*gDeltaTime //60fps change: per frame
            if y<-84 {instance_destroy()}
        }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.85 and bossProgress=0
    {
      atkDelay-=1
      bossProgress+=1
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=0; tAtkShield.atkUp=1
      shieldUp=1
    }
    else if lifePercent<=0.65 and bossProgress=1
    {
      atkDelay-=1
      fastMove=1
      bossProgress+=1
    }
    else if lifePercent<=0.45 and bossProgress=2
    {
      /*for(i=0;i<9;i+=1)     //replace with electricity
      {
        instance_create(304+(16*i),368,oMarioSpikeFloor)
        instance_create(640+(16*i),368,oMarioSpikeFloor)
      }*/
      spikeRise=1
      bossProgress+=1
      shieldUp=1
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=0; tAtkShield.atkUp=1
      weakcheck=1
    }
    else if lifePercent<=0.2 and bossProgress=3
    {
      //spikeRise=2
      bossProgress+=1
      shieldUp=1
    }
    else if lifePercent<=0.1 and bossProgress=4
    {
      atkDelay-=2
      bossProgress+=1
      shieldUp=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      with oTrapBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod (2/gDeltaTime)=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width)+random(sprite_width*2),(y-20)+random(sprite_height*4),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      global.currentBoss=""
      global.bossTrack=0
      global.newMapX=240; global.newMapY=496; room_goto(rSanctuary)
    }
  }
  enemyStepEvent()
}

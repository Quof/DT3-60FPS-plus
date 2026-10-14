if global.gamePaused=false
{
  if activateBoss=1
  {
    global.recBirdsSeen+=1
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0//; showBossHP.lifeFill=1000
    jeremyText="Jeremy is too busy laughing at Jerry to provide commentary."
    chaoText="I never got to meet this guy myself, so I'm excited to finally see how tough he really is.#...#Wow you guys were totally exaggerating, I don't see anything too difficult. I bet I could beat this at double speed."
    devText="I can't believe I didn't think of having a powered-up Rocketeer as a boss fight until the DLC. It's so obvious! Anyway, yes, this is actually a Rocketeer under there. At first I was just going to give him lots of health and no delays, but then I remembered the Shroudler sprite from Final Nightmare, and now we're here. He only has one lifebar so you shouldn't have too much trouble."
    activateBoss=2
  }

  if activateBoss=2 and life>0
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}
    /*if y<=oPlayer1.y-82 {image_index=0}
    else if y>=oPlayer1.y-81 and y<=oPlayer1.y-34 {image_index=1}
    else if y>=oPlayer1.y+34 and y<=oPlayer1.y+81 {image_index=3}
    else if y>=oPlayer1.y+82 {image_index=4}
    else {image_index=2}*/

    //event_user(0)
    if life>maxLife {life=maxLife}

    //Movement
    xPoint=oPlayer1.x+(88*atkSide)
    yPoint=oPlayer1.y-80 //orig: -128

    //60fps change: the speeds below change per frame, as in DT3+'s oCHAOS_Rocketeer
    if x>xPoint
    {
      //if currHspd>-maxSpeed {currHspd-=0.6}
      //else {currHspd+=0.6}
      if currHspd>-maxSpeed {currHspd-=0.6*gDeltaTime} //60fps change
      else {currHspd+=0.6*gDeltaTime} //60fps change
    }
    else if x<xPoint
    {
      //if currHspd<maxSpeed {currHspd+=0.6}
      //else {currHspd-=0.6}
      if currHspd<maxSpeed {currHspd+=0.6*gDeltaTime} //60fps change
      else {currHspd-=0.6*gDeltaTime} //60fps change
    }
    if y>yPoint
    {
      //if currVspd>-maxSpeed {currVspd-=0.6}
      //else {currVspd+=0.6}
      if currVspd>-maxSpeed {currVspd-=0.6*gDeltaTime} //60fps change
      else {currVspd+=0.6*gDeltaTime} //60fps change
    }
    else if y<yPoint
    {
      //if currVspd<maxSpeed {currVspd+=0.6}
      //else {currVspd-=0.6}
      if currVspd<maxSpeed {currVspd+=0.6*gDeltaTime} //60fps change
      else {currVspd-=0.6*gDeltaTime} //60fps change
    }
    //hspeed=currHspd; vspeed=currVspd
    _hspeed=currHspd; _vspeed=currVspd //60fps change: DT3+'s _hspeed/_vspeed (correctHSpeedVSpeed moves it, at the end), as DT3+'s oCHAOS_Rocketeer

    //Bob up and down
    //sLordMoveTime+=1
    //if sLordMoveTime>=1 and sLordMoveTime<=21 {sLordMove+=0.04}
    //else if sLordMoveTime>=22 and sLordMoveTime<=42 {sLordMove-=0.04}
    //else if sLordMoveTime>=52 and sLordMoveTime<=72 {sLordMove-=0.04}
    //else if sLordMoveTime>=73 and sLordMoveTime<=93 {sLordMove+=0.04}
    //60fps change: per frame, as DT3+'s oFinalNightmare (the same bob); windows start just after the previous tick (>0, >21, >51, >72) so all frames of their first tick count
    sLordMoveTime+=1*gDeltaTime
    if sLordMoveTime>0 and sLordMoveTime<=21 {sLordMove+=0.04*gDeltaTime}
    else if sLordMoveTime>21 and sLordMoveTime<=42 {sLordMove-=0.04*gDeltaTime}
    else if sLordMoveTime>51 and sLordMoveTime<=72 {sLordMove-=0.04*gDeltaTime}
    else if sLordMoveTime>72 and sLordMoveTime<=93 {sLordMove+=0.04*gDeltaTime}
    else if sLordMoveTime>=103 {sLordMoveTime=0}
    //y+=sLordMove
    y+=sLordMove*gDeltaTime //60fps change: per frame

    //shotTime+=1
    shotTime+=1*gDeltaTime //60fps change: per frame
    if shotType<30
    {
        //shotType+=1
        shotType+=1*gDeltaTime //60fps change: per frame (counts the wait up to 30; it lands on 30 exactly)
        if shotTime>0 {shotTime=0}
    }
    else if shotType>=30 and shotType<33 //Point explosion missile
    {
      if shotTime=shotDelay
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=0.875; tEffect.image_yscale=0.875
      }
      else if shotTime>=shotDelay+10
      {
        playSound(global.snd_CShotB,0,0.95,1)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPointExpBulletD)
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8+shotSpdAdj
        //tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        //shotDir=tNewAttack.direction
        tNewAttack._direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter()) //60fps change: DT3+'s bullets move by _direction
        shotDir=tNewAttack._direction //60fps change
        if bossProgress>=3
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y,oPointExpBulletD)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8+shotSpdAdj
          //tNewAttack.direction=shotDir+5
          tNewAttack._direction=shotDir+5 //60fps change: _direction
          var tNewAttack;
          tNewAttack=instance_create(x,y,oPointExpBulletD)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8+shotSpdAdj
          //tNewAttack.direction=shotDir-5
          tNewAttack._direction=shotDir-5 //60fps change: _direction
        }
        shotType+=1
        shotTime=0
      }
    }
    else if shotType>=33 and shotType<50 //Laser&Ball
    {
      if shotTime=1 and bShroudlerBall>=1 {bShroudlerBall+=1}
      if bShroudlerBall>=4  //Ball
      {
        //ballTime+=1
        ballTime+=1*gDeltaTime //60fps change: per frame
        if ballTime>=ballDelay
        {
            //ball
            var tFire;
            tFire=instance_create(x,y,oShroudlerBall)
            //tFire.direction=player_sprite_center()
            tFire._direction=player_sprite_center() //60fps change: the ball moves by _direction (its Step)
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
            ballTime=0
            bShroudlerBall=1
            shotType=0
            shotTime=0
        }
      }
      else  //laser
      {
          if shotTime=shotDelay+30 {bLaser=1; circleRad=2; circleCol=c_white}
          if shotTime>=shotDelay+30 and shotTime<=shotDelay+14+30 {laserDir=point_direction(x+(xOffset*image_xscale),y+yOffset,oPlayer1.x,returnPlayerYCenter())}
          else if shotTime=shotDelay+15+30 {circleRad=3; circleCol=c_red}
          else if shotTime=shotDelay+30+30
          {
            bLaser=0
            playSound(global.snd_CShotA,0,0.95,1)
            var tEffect,myLaser;
            tEffect=instance_create(x+(xOffset*image_xscale),y+yOffset,oEffect)
            tEffect.sprite_index=sEfPowerWave; tEffect.image_alpha=0.4; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=3; tEffect.image_angle=90+laserDir
            tEffect.image_xscale=0.8; tEffect.image_yscale=0.8

            myLaser=instance_create(x+(xOffset*image_xscale),y+yOffset,oC_RocketLaser)
            myLaser.image_angle=laserDir; myLaser.atkPower=atkPower
          }
          else if shotTime>=shotDelay+31+30
          {
            if atkSide=1 {atkSide=-1}
            else {atkSide=1}
            shotType=0
            shotTime=0
            /*if bShroudlerBall>0 {bShroudlerBall+=1}
            if bShroudlerBall>3 {bShroudlerBall=1; shotType=63}*/
          }
      }
    }
    /*else if shotType>=63
    {
        //shroudler ball

        shotType=0
        shotTime=0
    }*/

    // hand respawn timings
    if handA>=10
    {
        //handA-=1
        handA-=1*gDeltaTime //60fps change: per frame (lands on 10 exactly)
        if handA=10
        {
            var lefty;
            lefty=instance_create(x+88,y-4,oShroudlerHand)
            handA=1
        }
    }
    if handB>=10
    {
        //handB-=1
        handB-=1*gDeltaTime //60fps change: per frame
        if handB=10
        {
            var righty;
            righty=instance_create(x-88,y-4,oShroudlerHand)
            righty.image_xscale=-1
            handB=1
        }
    }
    if handC>=10
    {
        //handC-=1
        handC-=1*gDeltaTime //60fps change: per frame
        if handC=10
        {
            var leftwo;
            leftwo=instance_create(x+88,y-4,oShroudlerHand)
            leftwo.DIAG=1
            handC=1
        }
    }
    if handD>=10
    {
        //handD-=1
        handD-=1*gDeltaTime //60fps change: per frame
        if handD=10
        {
            var rightwo;
            rightwo=instance_create(x-88,y-4,oShroudlerHand)
            rightwo.DIAG=1
            rightwo.image_xscale=-1
            handD=1
        }
    }
  }

  // ----------------------- boss difficulty curve, now with less phase skipping -----------------------
  if lifePercent<.8 and bossProgress=0
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    bossProgress+=1
    bHandSpawn=1
    var lefty;
    lefty=instance_create(x+88,y-4,oShroudlerHand)
    handA=1
    var righty;
    righty=instance_create(x-88,y-4,oShroudlerHand)
    righty.image_xscale=-1
    handB=1
  }
  else if lifePercent<.4 and bossProgress=1
  {
    bossProgress+=1
    shotSpdAdj=2
  }
  else if lifePercent<.8 and bossProgress=3
  {
    bossProgress+=1
    //bShroudlerBall=1
  }
  else if lifePercent<.4 and bossProgress=4
  {
    bossProgress+=1
    shotSpdAdj=2
  }
  else if lifePercent<.25 and bossProgress=6
  {
    bossProgress+=1
    /*var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=0; tAtkShield.atkUp=1*/
    //resType[0]-=1
    //increases all hand resistances
  }

  // ----------------------- lifebar management; it's only one, I didn't lie :^) -----------------------
  if life<=0 and bossProgress=2
  {
    maxLife=1500
    life=maxLife
    bossProgress+=1
    shotTime=-15
    ballTime=0
    bShroudlerBall=1
    shotType=0
    bLaser=0
    shotSpdAdj=0
    maxSpeed+=1.5
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    //if instance_exists(lefty) {lefty.life=lefty.maxLife; lefty.handLaserTime=0}
    with oShroudlerHand {life=0}
    var lefty;
    lefty=instance_create(x+88,y-4,oShroudlerHand)
    handA=1
    var righty;
    righty=instance_create(x-88,y-4,oShroudlerHand)
    righty.image_xscale=-1
    handB=1
  }
  else if life<=0 and bossProgress=5
  {
    maxLife=500
    life=maxLife
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    bossProgress+=1
    shotTime=-45
    ballTime=0
    bShroudlerBall=1
    shotType=0
    bLaser=0
    bHandSpawn=2
    maxSpeed+=0.5
    /*resType[0]=2
    resType[3]=2*/
    with oShroudlerHand {life=0}
    var lefty;
    lefty=instance_create(x+88,y-4,oShroudlerHand)
    handA=1
    var righty;
    righty=instance_create(x-88,y-4,oShroudlerHand)
    righty.image_xscale=-1
    handB=1
    var leftwo;
    leftwo=instance_create(x+88,y-4,oShroudlerHand)
    leftwo.DIAG=1
    handC=1
    var rightwo;
    rightwo=instance_create(x-88,y-4,oShroudlerHand)
    rightwo.DIAG=1
    rightwo.image_xscale=-1
    handD=1
  }
  else if life<=0 and bossProgress=7 //Defeat animation from Final Nightmare
  {
    //deathAnim+=1
    if deathAnim==0 {deathAnim=1-gDeltaTime} //60fps change (added): the first frame is tick 1, as in DT3+'s oCHAOS_Rocketeer
    deathAnim+=1*gDeltaTime //60fps change: per frame
    if deathAnim=1
    {
      //speed=0
      _hspeed=0; _vspeed=0 //60fps change: DT3+'s _hspeed/_vspeed (it moves by those; "speed=0" stopped the built-in ones)
      with oShroudlerHand {life=0}
      with oEProjectileBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      //if oGame.time mod 1=0
      if oGame.time mod (1/gDeltaTime)=0 //60fps change: once per 30fps tick (oGame.time counts frames)
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      /*if global.bBossGallery=1
      {
        bossRoomTally(8)
        global.newMapX=1864; global.newMapY=1280; room_goto(rBossGallery)
      }
      else
      {*/
      global.currentBoss=""
      global.bossTrack=0
      oDT1.sceneProgress+=1
      instance_destroy()
      /*}*/
    }
  }
  enemyStepEvent()
  if life>0 {bCanTakeDamage=true}
}
//else {hspeed=0; vspeed=0}
else {_hspeed=0; _vspeed=0} //60fps change: DT3+'s _hspeed/_vspeed
correctHSpeedVSpeed(self) //60fps change (added): moves it by _hspeed/_vspeed, as DT3+'s oCHAOS_Rocketeer

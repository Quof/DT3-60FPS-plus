#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=0; bCanTakeDamage=0
image_xscale=0.8; image_yscale=0.8
currHspd=0; currVspd=0
imageEffect=0
jawAngle=0
tongueXscale=0
tongueAngle=0

//Enemy base statistics
eName="Shadow Eura"
eLevel=36
maxLife=9000
life=maxLife
atkPower=10
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[3]=3
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
rockPos=2 //1-Left, 2-Middle, 3-Right
rockProg=0
atkTime=0
xPoint=0
yPoint=0
mySide=1 //1-Left, 2-Right
sideSwap=0

maxSpeed=4
hitNum=0
rockWaveNum=12

darkBallTime=0
darkBallDelay=240
darkBallNum=2
mouthBallTime=0
mouthBallDelay=290
mouthBallNum=0
deflectorTime=0
deflectorDelay=410
deflectorHits=0
correctResType=0
firePillarTime=0
firePillarDelay=260
tongueAttack=0
bloodBulletDir=0
bloodBulletNum=0
//--------------------

//Misc Data
xCenter=352
yGround=288
roomSpan=192

jeremyText=""
chaoText="It has 2 main attacks. The first is a spinning ball, that once it hits the ground, creates a fire wave. You can lure these away. The other is a simple fireball from its mouth, but the last one is fired faster and explodes at the point it was fired at you. It has some other tricks that seem to activate as it takes damage. One of them has something to do with deflecting projectiles."
devText="Originally this boss was going to be a big puzzle boss, but a bit before starting work on it, some of its design changed. The rock phase is a remnant of that older bit and a few other elements which you may not have seen yet, so I won't spoil that."

deathAnim=0

myRock=instance_create(x,y,oSE_Rock); myRock.type=1; myRock.atkTime=60
myRockA=instance_create(256,76,oSE_Rock); myRockA.type=2; myRockA.atkTime=30
myRockB=instance_create(448,76,oSE_Rock); myRockB.type=2; myRockB.atkTime=120
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
    if rockProg>=2 and rockProg<=9 and (tongueAttack<60 or tongueAttack>1000)
    {
      if x<oPlayer1.x {image_xscale=1} else {image_xscale=-1}
      imageEffect+=1
      if imageEffect mod 4=0 //Afterimage
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
        tAfterI.image_alpha=0.4; tAfterI.image_xscale=image_xscale; tAfterI.depth=80; tAfterI.imageFade=0.025
        tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0; tAfterI.xShift=0; tAfterI.yShift=0
        if deflectorTime>=deflectorDelay
        {
          tAfterI.xScaling=0.2*image_xscale; tAfterI.yScaling=0.2
        }
        else
        {
          tAfterI.xScaling=0; tAfterI.yScaling=0
        }
      }
    }

    if rockProg=0 //========== Rock exists ==========
    {
      if instance_exists(myRock)
      {
        x=myRock.x+8
        y=myRock.y+10
        if life<maxLife {life+=1}
      }
    }
    else if rockProg=1 //========== Break out of rock ==========
    {
      atkTime+=1
      if atkTime>=15 and atkTime<=49
      {
        if atkTime mod 2=0 {x-=1}
        else {x+=1}
      }
      if atkTime=50
      {
        jeremyText="I can't seem to get any data on this thing. Hex keeps changing how he blocks me out of this stuff. Sorry you guys, I just can't figure out how to get through it, luckily Chao's able to decipher some things on her end."
        with oSE_Rock {life=0}
        var tAtk,tDir;
        tDir=0
        for(i=0;i<rockWaveNum;i+=1)
        {
          tAtk=instance_create(x,y,oPassBulletRed)
          tAtk.sprite_index=sSE_ShotA; tAtk.bulletSpeed=5; tAtk.decayTime=-100; tAtk.direction=tDir; tAtk.atkPower=atkPower
          tDir+=360/rockWaveNum
        }
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        bCanDealDamage=1; bCanTakeDamage=1
      }
      else if atkTime>=60
      {
        atkTime=0
        rockProg=2
      }
    }
    else if rockProg=2 //========== Rise up to middle of the room ==========
    {
      y-=2
      if y<=152
      {
        if oPlayer1.x<xCenter {mySide=2}
        else {mySide=1}
        darkBallTime=darkBallDelay-30
        mouthBallTime=40
        rockProg=3
      }
    }
    else if rockProg=3 //========== Standard behavior ==========
    {
      if tongueAttack<60 or tongueAttack>1000
      {
        //---------- Movement ----------
        if mySide=2 //Right
        {
          if oPlayer1.x>xCenter
          {
            sideSwap+=1
            if sideSwap=15 {sideSwap=0; mySide=1}
          }
          else {sideSwap=0}

          var tXCheck;
          tXCheck=(xCenter-oPlayer1.x)/1.85
          xPoint=496-tXCheck
        }
        else //Left
        {
          if oPlayer1.x<xCenter
          {
            sideSwap+=1
            if sideSwap=15 {sideSwap=0; mySide=2}
          }
          else {sideSwap=0}

          var tXCheck;
          tXCheck=(oPlayer1.x-xCenter)/1.85
          xPoint=208+tXCheck
        }

        var tYCheck;
        tYCheck=(yGround-oPlayer1.y)/4.5
        yPoint=176-tYCheck

        if x>xPoint
        {
          if currHspd>-maxSpeed {currHspd-=0.4}
          else {currHspd+=0.4}
        }
        else if x<xPoint
        {
          if currHspd<maxSpeed {currHspd+=0.4}
          else {currHspd-=0.4}
        }
        if y>yPoint
        {
          if currVspd>-maxSpeed {currVspd-=0.4}
          else {currVspd+=0.4}
        }
        else if y<yPoint
        {
          if currVspd<maxSpeed {currVspd+=0.4}
          else {currVspd-=0.4}
        }
        hspeed=currHspd; vspeed=currVspd

        //---------- ATTACK: DARK BALL ----------
        darkBallTime+=1
        if darkBallTime>=darkBallDelay and darkBallTime<=darkBallDelay+19
        {
          if darkBallTime mod 5=0 or darkBallTime=darkBallDelay
          {
            playSound(global.snd_Flame1,0,0.98,19000)
            var tEfCir;
            tEfCir=instance_create(x,y,oEfCircleSoftFade)
            tEfCir.image_alpha=0.4; tEfCir.myRad=20; tEfCir.radScl=1.5; tEfCir.fadeSpeed=0.02
          }
        }
        else if darkBallTime>=darkBallDelay+25
        {
          SS_StopSound(global.snd_Flame1)
          playSound(global.snd_OrbThrow,0,0.98,17000)
          var myAtk;
          for(i=0;i<darkBallNum;i+=1)
          {
            myAtk=instance_create(x,y,oSE_DarkBall)
            myAtk.atkPower=atkPower
            myAtk.bulletSpeed=1.5+(i*1.5)
            if x<xCenter {myAtk.direction=5-(i*5)}
            else {myAtk.direction=185-(i*5)}
          }
          darkBallTime=0
        }

        //---------- ATTACK: MOUTH BALL ----------
        mouthBallTime+=1
        if mouthBallTime>=mouthBallDelay and mouthBallTime<=mouthBallDelay+100
        {
          mouthBallTime=10000
        }
        else if mouthBallTime>=10001 and mouthBallTime<=10030 {jawAngle-=1}
        else if mouthBallTime=10050
        {
          playSound(global.snd_RidleyFire,0,0.95,36000)
          var tNewAttack,tDirOff;
          if image_xscale=1 {tDirOff=235}
          else {tDirOff=305}
          tNewAttack=instance_create(x+lengthdir_x(13,tDirOff+image_angle),y+lengthdir_y(13,tDirOff+image_angle),oPassBullet)
          tNewAttack.sprite_index=sSE_ShotB; tNewAttack.atkPower=atkPower
          tNewAttack.bulletSpeed=6+(mouthBallNum/2); tNewAttack.decayTime=-100; tNewAttack.depth=30
          tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
          mouthBallNum+=1
          if mouthBallNum>=4
          {
            mouthBallNum=0
            mouthBallTime=10100
          }
          else {mouthBallTime=10036}
        }
        else if mouthBallTime=10125
        {
          playSound(global.snd_RidleyFire,0,0.95,15000)
          var tNewAttack;
          tNewAttack=instance_create(x,y,oPointExpBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=10; tNewAttack.sprite_index=sSE_DarkBall
          tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        }
        else if mouthBallTime>=10101 and mouthBallTime<=10130 {jawAngle+=1}
        else if mouthBallTime>=10131 {mouthBallTime=0}

        //---------- ATTACK: FIRE PILLAR ----------
        if bossProgress>=2
        {
          firePillarTime+=1
          if firePillarTime=firePillarDelay
          {
            var tEffect;
            tEffect=instance_create(x,y,oEffect)
            tEffect.sprite_index=sMMchargeComplete; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.image_xscale=2; tEffect.image_yscale=2
            tFirePillar=instance_create(208,256,oDracFireWave)
            tFirePillar.atkPower=atkPower; tFirePillar.depth=30; tFirePillar.image_xscale=0.75
            tFirePillar=instance_create(496,256,oDracFireWave)
            tFirePillar.atkPower=atkPower; tFirePillar.depth=30; tFirePillar.image_xscale=0.75
            firePillarTime=0
          }
        }

        //---------- UTILITY: DEFLECTOR ----------
        if bossProgress>=1
        {
          if deflectorTime<deflectorDelay {deflectorTime+=1}
        }
      }

      //---------- DESPERATION ATTACK: BLOODY TONGUE ----------
      if bossProgress>=2
      {
        if oGame.time mod 2=0 {tongueAngle=1}
        else {tongueAngle=0}

        tongueAttack+=1
        if tongueAttack=60 //Immune and stop
        {
          playSound(global.snd_DemonTalk,0,1,13000)
          bCanTakeDamage=0
          oEvDCS.fadeColor=c_red
          hspeed=0; vspeed=0
        }
        else if tongueAttack>=80 and tongueAttack<=199 //Go to point
        {
          image_xscale=-1
          direction=point_direction(x,y,448,160)
          speed=3
          if point_distance(x,y,448,160)<5
          {
            speed=0
            tongueAttack=200
          }
        }
        else if tongueAttack>=211 and tongueAttack<=250 {oEvDCS.fadeAlpha+=0.005} //Red fade - 0.2
        else if tongueAttack>=271 and tongueAttack<=330 //Open jaw
        {
          image_angle-=0.5
          jawAngle-=0.5
        }
        else if tongueAttack=340 {playSound(global.snd_DemonLaugh,0,1,13000)}
        else if tongueAttack>=341 and tongueAttack<=360 {tongueXscale+=0.05} //Extend tongue
        else if tongueAttack>=370 and tongueAttack<=460 //Blood from mouth
        {
          var tNewAtk;
          tNewAtk=instance_create(x,y+10,oGravPassBullet)
          tNewAtk.sprite_index=sSE_Blood; tNewAtk.image_speed=0.1; tNewAtk.depth=30; tNewAtk.atkPower=atkPower
          tNewAtk.xVel=-1-random(1.5); tNewAtk.yVel=random(1); tNewAtk.grav=0.2
        }
        else if tongueAttack>=461 and tongueAttack<=490 //Remove red fade and close jaw
        {
          if oEvDCS.fadeAlpha>0 {oEvDCS.fadeAlpha-=0.01}
          if tongueXscale>0 {tongueXscale-=0.1}
          image_angle+=1
          jawAngle+=1
        }
        else if tongueAttack=500 //End attack
        {
          bCanTakeDamage=1
          tongueAttack=1000
        }

        //Bullet attack
        if tongueAttack=410
        {
          playSound(global.snd_OrbThrow,0,1,13000)
          tDir=0
          for(i=0;i<70;i+=1)
          {
            tAtk=instance_create(x,y,oPassBullet)
            tAtk.sprite_index=sSE_ShotB; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=tDir; tAtk.atkPower=atkPower
            tAtk.image_xscale=0.75; tAtk.image_yscale=0.75
            tDir+=360/70
          }
          tDir=bloodBulletDir
          bloodBulletDir+=7.5
          for(i=0;i<16;i+=1)
          {
            tAtk=instance_create(x,y,oPassBulletRed)
            tAtk.sprite_index=sSE_ShotA; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=tDir; tAtk.atkPower=atkPower
            tAtk=instance_create(x,y,oPassBulletRed)
            tAtk.sprite_index=sSE_ShotA; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=tDir+3; tAtk.atkPower=atkPower
            tDir+=360/16
          }
        }
        else if tongueAttack=450
        {
          bloodBulletNum+=1
          if bloodBulletNum>=7 {tongueAttack=451}
          else {tongueAttack=409}
        }
      }
    }
    else if rockProg=10 //========== Mist away ==========
    {
      atkTime+=1
      if atkTime=1 //Set immune
      {
        playSound(global.snd_BoxBreak,0,1,11025)
        jeremyText=""
        bCanDealDamage=0; bCanTakeDamage=0
        deflectorTime=0; deflectorHits=0
        currHspd=4*image_xscale; currVspd=2
      }
      if atkTime>=1 and atkTime<=10 {image_alpha-=0.1}

      if currHspd>1 {currHspd-=0.1}
      else if currHspd<-1 {currHspd+=0.1}
      if currVspd>-4 {currVspd-=0.2}
      hspeed=currHspd; vspeed=currVspd

      for(i=0;i<8;i+=1) //Mist particles
      {
        tEffect=instance_create(x+random_range(-24,24),y+random_range(-24,24),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=23; tEffect.image_blend=c_purple
        tEffect.image_speed=0.2; tEffect.fadeSpd=0.075; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }

      if y<=-80
      {
        hspeed=0; vspeed=0
        atkTime=0
        rockProg=11
      }
    }
    else if rockProg=11 //========== Slight wait ==========
    {
      atkTime+=1
      if atkTime>=30
      {
        image_xscale=0.8; image_yscale=0.8; image_alpha=1
        darkBallTime=0; mouthBallTime=0
        jawAngle=0
        atkTime=0; rockProg=12
      }
    }
    else if rockProg=12 //========== Send rocks down ==========
    {
      atkTime+=1
      if atkTime=1
      {
        y=-36
        if bossProgress=1
        {
          x=448
          myRock=instance_create(448,-36,oSE_Rock); myRock.type=1; myRock.atkTime=-1000000
          myRockA=instance_create(256,-36,oSE_Rock); myRockA.type=2; myRockA.atkTime=-1000000
          myRockB=instance_create(352,-36,oSE_Rock); myRockB.type=2; myRockB.atkTime=-1000000
        }
        else if bossProgress=2
        {
          x=256
          myRock=instance_create(256,-36,oSE_Rock); myRock.type=1; myRock.atkTime=-1000000
          myRockA=instance_create(352,-36,oSE_Rock); myRockA.type=2; myRockA.atkTime=-1000000
          myRockB=instance_create(448,-36,oSE_Rock); myRockB.type=2; myRockB.atkTime=-1000000
        }

        /*
        if oPlayer1.x<xCenter {rockPos-=1}
        else {rockPos+=1}
        if rockPos=0 {rockPos=3}
        else if rockPos=4 {rockPos=1}
        if rockPos=1
        {
          x=256
          myRock=instance_create(256,-36,oSE_Rock); myRock.type=1; myRock.atkTime=-1000000
          myRockA=instance_create(352,-36,oSE_Rock); myRockA.type=2; myRockA.atkTime=-1000000
          myRockB=instance_create(448,-36,oSE_Rock); myRockB.type=2; myRockB.atkTime=-1000000
        }
        else if rockPos=2
        {
          x=352
          myRock=instance_create(352,-36,oSE_Rock); myRock.type=1; myRock.atkTime=-1000000
          myRockA=instance_create(256,-36,oSE_Rock); myRockA.type=2; myRockA.atkTime=-1000000
          myRockB=instance_create(448,-36,oSE_Rock); myRockB.type=2; myRockB.atkTime=-1000000
        }
        else if rockPos=3
        {
          x=448
          myRock=instance_create(448,-36,oSE_Rock); myRock.type=1; myRock.atkTime=-1000000
          myRockA=instance_create(256,-36,oSE_Rock); myRockA.type=2; myRockA.atkTime=-1000000
          myRockB=instance_create(352,-36,oSE_Rock); myRockB.type=2; myRockB.atkTime=-1000000
        }*/
      }
      else if atkTime>=2 and atkTime<=999
      {
        var tEffect;
        for(i=0;i<3;i+=1)
        {
          for(ii=0;ii<8;ii+=1)
          {
            tEffect=instance_create(224+(i*96)+random(64),myRock.y-32+random(64),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=23
            tEffect.image_speed=0.2; tEffect.fadeSpd=0.075; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
        }
        myRock.y+=1; myRockA.y+=1; myRockB.y+=1
        if myRock.y>=76 {atkTime=1000}
      }
      else if atkTime>=1010
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        resType[3]=3
        myRock.atkTime=60; myRockA.atkTime=30; myRockB.atkTime=120
        deflectorTime=200
        atkTime=0
        rockProg=0
      }
    }
  }

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.66 and lifePercent>=0.34 and bossProgress=0
  {
    rockProg=10; atkTime=0
    darkBallNum+=1
    rockWaveNum+=2
    darkBallDelay-=5
    mouthBallDelay-=10
    bossProgress+=1
  }
  else if lifePercent<=0.33 and lifePercent>=0 and bossProgress=1
  {
    rockProg=10; atkTime=0
    darkBallNum+=1
    rockWaveNum+=2
    darkBallDelay-=5
    mouthBallDelay-=10
    bossProgress+=1
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim=1
  {
    if global.bBossGallery=1
    {
      bossRoomTally(54)
      global.newMapX=184; global.newMapY=560; room_goto(rBossGallery)
    }
    else
    {
      with oEnemyAfterImage {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}

      deflectorTime=0
      global.gamePaused=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.visible=0; oPlayer1.x=352; oPlayer1.y=288
      x=352; y=176

      mashingButtons=instance_create(0,0,oMashButtons)
      mashingButtons.xCenter=352; mashingButtons.yCenter=160
      mashingButtons.startJerryX=448; mashingButtons.startJerryY=176
      mashingButtons.startClaireX=256; mashingButtons.startClaireY=176
    }
  }
  else if deathAnim=15
  {
    msgCreate(0,0,"Jerry","This thing is way too gross.",0,1,oMessagePerson,0)
    newMessage.fadingTime=60
  }
  else if deathAnim=80
  {
    msgCreate(0,0,"Claire","Agreed!!",0,0,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if deathAnim=135
  {
    mashingButtons.bCanHit=1
  }
  else if deathAnim>=145 and deathAnim<=155
  {
    if deathAnim=150 {deathAnim=145}

    if mashingButtons.timeToStop<=0
    {
      global.gamePaused=false
      mashingButtons.bCanHit=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.visible=1
      deathAnim=165
    }
  }
  else if deathAnim>=166 and deathAnim<=225
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod 2=0
    {
      var tEffect;
      tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>=226
  {
    oEvDCS.sceneProgress=1
    instance_destroy()
  }
}
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if deflectorTime>=deflectorDelay
{
  if other.weaponTag=1 or other.weaponTag=10 or other.weaponTag=11 or other.weaponTag=12 or other.weaponTag=31 or other.weaponTag=40 or other.weaponTag=41
  {
    for(i=0;i<6;i+=1)
    {
      resType[i]=1
    }
    var tNewAttack;
    tNewAttack=instance_create(x,y,oPassBullet)
    tNewAttack.sprite_index=other.sprite_index; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7
    tNewAttack.decayTime=-100
    tNewAttack.direction=point_direction(x+(16*image_xscale),y+16,oPlayer1.x,returnPlayerYCenter())
    correctResType=1
  }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if rockProg=0 and bCanTakeDamage=1
{
  hitNum+=1
  if hitNum=12
  {
    bCanTakeDamage=0
    image_xscale=1; image_yscale=1
    hitNum=0
    rockProg+=1
  }
}

if deflectorTime>=deflectorDelay
{
  if other.weaponTag=0 or other.weaponTag=30
  {
    deflectorHits+=1
    if deflectorHits>=4
    {
      deflectorHits=0; deflectorTime=0
    }
  }
}

if correctResType=1
{
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  correctResType=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if rockProg>=1 and rockProg<=11
{
  if tongueXscale>0 //Insert tongue joke here
  {
    draw_sprite_ext(sShadowEura_Tongue,image_index,x,y+10,tongueXscale,1,185+tongueAngle,image_blend,image_alpha)
    draw_sprite_ext(sShadowEura_Tongue,image_index,x,y+10,tongueXscale,1.1,195+tongueAngle,image_blend,image_alpha)
  }

  if image_xscale=1
  {
    draw_sprite_ext(sShadowEura_Brain,image_index,x+lengthdir_x(20,130+image_angle),y+lengthdir_y(20,130+image_angle),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sShadowEura_Jaw,image_index,x+lengthdir_x(13,235+image_angle),y+lengthdir_y(13,235+image_angle),image_xscale,image_yscale,image_angle+jawAngle,image_blend,image_alpha)
    draw_sprite_ext(sShadowEura_Eye,image_index,x+lengthdir_x(2,35+image_angle),y+lengthdir_y(2,35+image_angle),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  else
  {
    draw_sprite_ext(sShadowEura_Brain,image_index,x+lengthdir_x(20,50+image_angle),y+lengthdir_y(20,50+image_angle),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sShadowEura_Jaw,image_index,x+lengthdir_x(13,305+image_angle),y+lengthdir_y(13,305+image_angle),image_xscale,image_yscale,image_angle-jawAngle,image_blend,image_alpha)
    draw_sprite_ext(sShadowEura_Eye,image_index,x+lengthdir_x(2,145+image_angle),y+lengthdir_y(2,145+image_angle),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
else
{
  draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
}

#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-21,-40,21,-1)
image_speed=0
image_xscale=-1
bCanTakeDamage=false

//Enemy base statistics
eName="Elpizo"
eLevel=20
maxLife=5600
life=maxLife
atkPower=7
resType[0]=2
resType[1]=2
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

//-- Movement Data --
moveSpd=9
chargeArc=3

//-- Neutral Data --
currentAction=0
lastAction=0
attackDelay=0
waitTime=45

//-- Dark Needle Data --
needleEnd=30
needleSpc=12
needleMod=5

//-- Bubble Data --
bubbleDecay=60

//-- Portal Data --
portalAction=0
portalDecay=180
portalArc=3

//-- Defense Data --
actNoTele=1
teleInc=0.75

//-- Special Data --
specProg=0
specTime=0
specMax=1800
specBackAlpha=0
specHP=15
specDir=0
maxSpeed=2
currHspd=0; currVspd=0
timeMod=0 //At 33% HP, if the Desperation attack has not been used at least once, the bar fills faster until the attack occurs

//-- Misc Data --
xCenter=448
yGround=416
roomSpan=320

nightmareZoneA=-1
nightmareZoneB=-1
nightmareZoneC=-1
nightmareZoneD=-1

deathAnim=0

jeremyText="This guy has a number of actions which all look to become harder as he's damaged. I recommend not jumping when it's not necessary if you're close to him. He has a move where he'll jump back and throw a super fast projectile toward you. If you don't have a dash ready when you're nearby, there's no chance of dodging it. There's also these nifty portal looking things that he'll use to shield himself."
chaoText="Elpizo is the antagonist of Mega Man Zero 2. Though in the end he wasn't really a villain. I guess I can see why the program read him in as hostile. That or the Virus is messing with things. At times, Elpizo will summon up those nightmare zones that slow down projectiles. If you touch those, it charges his super attack. Damaging his shielding portals does as well."
devText="The Nightmare Effect comes from Mega Man X6 and created random effects on the stages. The effect used in Gate D is simply that it slows down platforms and projectiles. Though it's an exclusive feature for this level, like the shadows for Gate C were, I didn't want the level to focus on it too much. The main focus is tight jumps and having the player make heavy use of the wall jump."
extraInfo="Capable of shielding and being annoying."

myHS=instance_create(x,y,oElpizoHitSpot)
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
    myHS.bActive=true
    myHS.bShowHealthBar=true
    myHS.showBossHP=instance_create(0,0,oBossLifeDisplay)
    myHS.showBossHP.bossID=myHS.id
    myHS.showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and myHS.life>0
  {
    if specProg=0
    {
      if specTime>=specMax //Go into desperation mode
      {
        if currentAction=0 and attackDelay>1 and attackDelay<waitTime-1
        {
          if timeMod=1 {timeMod=2}
          specProg=1
        }
      }

      if currentAction=0 //---------- No action: Ready ----------
      {
        if x<=oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}

        attackDelay+=1
        if attackDelay>=waitTime
        {
          if instance_number(oElpizoPortal)=0 //Chance to use portal if none are active
          {
            if random(10)<=portalArc {currentAction=40}
          }
          /*else if instance_number(oElpizoPortal)=1
          {
            if random(10)<=portalArc/2 {currentAction=40}
          }*/

          if actNoTele>=3 //Chance to teleport if he has not teleported in a few actions
          {
            if random(10)<=actNoTele {currentAction=50}
          }

          if currentAction=0
          {
            if y<=320
            {
              if actNoTele<1.5
              {
                if lastAction=10 {currentAction=choose(30,40)}
                else if lastAction=30 {currentAction=choose(10,40)}
                else if lastAction=40 {currentAction=choose(10,30)}
                else {currentAction=choose(10,40)}
              }
              else
              {
                if lastAction=10 {currentAction=choose(20,30)}
                else if lastAction=20 {currentAction=choose(30,60)}
                else if lastAction=30 {currentAction=choose(10,60)}
                else if lastAction=40 {currentAction=choose(10,20)}
                else if lastAction=50 {currentAction=choose(20,60)}
                else if lastAction=60 {currentAction=choose(10,20)}
              }
            }
            else
            {
              if lastAction=10 {currentAction=choose(20,30)}
              else if lastAction=20 {currentAction=choose(30,60)}
              else if lastAction=30 {currentAction=choose(10,60)}
              else if lastAction=40 {currentAction=choose(10,20)}
              else if lastAction=50 {currentAction=choose(20,60)}
              else if lastAction=60 {currentAction=choose(10,20)}
            }
          }
          if currentAction=0 {currentAction=60} //Fail safe against no action taken

          if currentAction=40 //Change action if portal chosen when one exists - Removed Action(Using portals to shield both sides)
          {
            if instance_number(oElpizoPortal)=1 {currentAction=choose(20,60)}
            //portalAction=1
            //event_user(0)
          }
          lastAction=currentAction
          attackDelay=0
        }
      }
      else if currentAction>=10 and currentAction<=19 //--------------- Attack: Dark Needles ---------------
      {
        attackDelay+=1
        if attackDelay=1 {sprite_index=sElpizoNeedleLaunch} //Raise sword up
        else if attackDelay=5 {image_index=1}
        else if attackDelay=9 {image_index=2}
        else if attackDelay=13 {image_index=3}
        else if attackDelay=17 {image_index=4}
        else if attackDelay=21 {image_index=5}
        else if attackDelay=29
        {
          var tNeedleTip;
          tNeedleTip=instance_create(x-(3*image_xscale),y-93,oMisc)
          tNeedleTip.sprite_index=sE_DN_Tip; tNeedleTip.image_speed=0.4; tNeedleTip.depth=24; tNeedleTip.type=1
        }
        else if attackDelay>=35 and attackDelay<=35+needleEnd
        {
          if attackDelay=35
          {
            if image_xscale=1
            {
              if bossProgress>=4 {needleDirA=89; needleDirB=91}
              else {needleDirA=0; needleDirB=180}
              needleArc=-needleSpc
            }
            else
            {
              if bossProgress>=4 {needleDirA=91; needleDirB=89}
              else {needleDirA=180; needleDirB=0}
              needleArc=needleSpc
            }
          }
          if attackDelay mod needleMod=0
          {
            playSound(global.snd_SniperShot,0,0.96,37000)
            var tNewAtk;
            tNewAtk=instance_create(x-(3*image_xscale),y-93,oPassBullet)
            tNewAtk.sprite_index=sE_DarkNeedle; tNewAtk.image_speed=0.5
            tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=13; tNewAtk.decayTime=-100; tNewAtk.direction=needleDirA
            if bossProgress>=2
            {
              tNewAtk=instance_create(x-(3*image_xscale),y-93,oPassBullet)
              tNewAtk.sprite_index=sE_DarkNeedle; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=13; tNewAtk.decayTime=-100; tNewAtk.direction=needleDirB
            }
            needleDirA+=needleArc; needleDirB-=needleArc
          }
        }
        else if attackDelay>=36+needleEnd and attackDelay<10000 //End attack sequence
        {
          attackDelay=10000
          with oMisc {instance_destroy()}
        }
        else if attackDelay=10001 {image_index=4} //Put sword down
        else if attackDelay=10004 {image_index=3}
        else if attackDelay=10007 {image_index=2}
        else if attackDelay=10010 {image_index=1}
        else if attackDelay=10013 {image_index=0}
        else if attackDelay=10016
        {
          sprite_index=sElpizoIdle
          actNoTele+=teleInc; currentAction=0; attackDelay=0
        }
      }
      else if currentAction>=20 and currentAction<=29 //--------------- Attack: Fast Slashes ---------------
      {
        attackDelay+=1
        if attackDelay=1 {sprite_index=sElpizoFastSlashesA} //Raise sword up
        else if attackDelay=4 {image_index=1}
        else if attackDelay=7 {image_index=2}
        else if attackDelay=10 {image_index=3}
        else if attackDelay=13 {sprite_index=sElpizoFastSlashesB; image_index=0}
        else if attackDelay>=16 and attackDelay<=61
        {
          image_index+=0.2
          xVel=moveSpd*image_xscale
          if attackDelay mod 5=0
          {
            if attackDelay mod 2=0 {playSound(global.snd_PlayerAtk[0],0,0.96,28000+random(6000))}
            else {playSound(global.snd_PlayerAtk[1],0,0.96,28000+random(6000))}
            var tNewAtk;
            tNewAtk=instance_create(x,y,oElpizoSwordAtk)
            tNewAtk.image_xscale=image_xscale; tNewAtk.atkPower=atkPower; tNewAtk.yOffset=14+random(16)
          }
        }
        else if attackDelay=62
        {
          xVel=0
          image_index=3
          sprite_index=sElpizoFastSlashesA
        }
        else if attackDelay=65 {image_index=2}
        else if attackDelay=68 {image_index=1}
        else if attackDelay=71 {image_index=0}
        else if attackDelay=74
        {
          sprite_index=sElpizoIdle
          actNoTele+=teleInc; currentAction=0; attackDelay=0
        }
      }
      else if currentAction>=30 and currentAction<=39 //--------------- Attack: Bubble Launch ---------------
      {
        attackDelay+=1
        if attackDelay=1 {sprite_index=sElpizoBubbleLaunch}
        else if attackDelay=10 {playSound(global.snd_OrbThrow,0,1,1)}
        else if attackDelay=25
        {
          var tBubbleAtk;
          tBubbleAtk=instance_create(x-(26*image_xscale),y-46,oElpizoBubbleCon)
        }
        else if attackDelay=50
        {
          sprite_index=sElpizoIdle
          actNoTele+=teleInc; currentAction=0; attackDelay=0
        }
      }
      else if currentAction>=40 and currentAction<=49 //--------------- Attack: Portal ---------------
      {
        attackDelay+=1
        if attackDelay=1 {sprite_index=sElpizoPortalLaunch} //Bring arm out
        else if attackDelay=5 {image_index=1}
        else if attackDelay=9 {image_index=2}
        else if attackDelay=13 {image_index=3}
        else if attackDelay=20
        {
          playSound(global.snd_PortalCreate,0,0.98,1)
          var tPortalAtk;
          tPortalAtk=instance_create(x+(25*image_xscale),y-24,oElpizoPortal)
          tPortalAtk.image_xscale=image_xscale; tPortalAtk.atkPower=atkPower
        }
        else if attackDelay=28 {image_index=2}
        else if attackDelay=32 {image_index=1}
        else if attackDelay=36 {image_index=0}
        else if attackDelay=40
        {
          sprite_index=sElpizoIdle
          actNoTele+=teleInc; currentAction=0; attackDelay=0
        }
      }
      else if currentAction>=50 and currentAction<=59 //--------------- Action: Teleport ---------------
      {
        attackDelay+=1
        if attackDelay=1 {xVel=0; yVel=0; sprite_index=sElpizoTeleport}
        else if attackDelay=5 {image_index=1}
        else if attackDelay=12
        {
          playSound(global.snd_OrbThrow,0,0.98,14000)
          myHS.bCanTakeDamage=false
          bCanDealDamage=false
        }
        else if attackDelay>=13 and attackDelay<=22 {image_alpha-=0.1}
        else if attackDelay=23 //Choose teleport spot
        {
          var tNextLoc;
          tNextLoc=irandom_range(1,3)
          if tNextLoc=1 {x=448; y=176}
          else if tNextLoc=2 {x=256; y=256}
          else if tNextLoc=3 {x=640; y=256}
        }
        else if attackDelay>=28 and attackDelay<=37 {image_alpha+=0.1}
        else if attackDelay=38
        {
          myHS.bCanTakeDamage=true
          bCanDealDamage=true
        }
        else if attackDelay=42 {image_index=1}
        else if attackDelay=46
        {
          xVel=0; yVel=0
          sprite_index=sElpizoIdle
          actNoTele=0; currentAction=0; attackDelay=0
        }
      }
      else if currentAction>=60 and currentAction<=69 //--------------- Attack: Jump back and throw dark needles ---------------
      {
        attackDelay+=1
        if attackDelay=1 {sprite_index=sElpizoPortalLaunch} //Bring arm out
        else if attackDelay=5 {image_index=1}
        else if attackDelay=9 {image_index=2}
        else if attackDelay=13
        {
          playSound(global.snd_PlayerJump[2],0,0.98,32000)
          sprite_index=sElpizoJump; image_index=0
          xVel=4*-image_xscale
          y-=2
          yVel=-6
        }
        else if attackDelay=21
        {
          playSound(global.snd_SniperShot,0,0.98,18000)
          sprite_index=sElpizoPortalLaunch; image_index=3
          var tNewAtk,tDir;
          tDir=point_direction(x+(19*image_xscale),y-23,oPlayer1.x,oPlayer1.y-26)
          tNewAtk=instance_create(x+(19*image_xscale),y-23,oPassBullet)
          tNewAtk.sprite_index=sE_DarkNeedle; tNewAtk.image_speed=0.5
          tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=15; tNewAtk.decayTime=-100; tNewAtk.direction=tDir
          if bossProgress=2 or bossProgress=3
          {
            tDir-=15
            for(i=0;i<2;i+=1)
            {
              tNewAtk=instance_create(x+(19*image_xscale),y-23,oPassBullet)
              tNewAtk.sprite_index=sE_DarkNeedle; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=15; tNewAtk.decayTime=-100; tNewAtk.direction=tDir
              tDir+=30
            }
          }
          else if bossProgress>=4
          {
            tDir-=25
            for(i=0;i<4;i+=1)
            {
              tNewAtk=instance_create(x+(19*image_xscale),y-23,oPassBullet)
              tNewAtk.sprite_index=sE_DarkNeedle; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=15; tNewAtk.decayTime=-100; tNewAtk.direction=tDir
              tDir+=17
            }
          }
        }
        if attackDelay=24 {sprite_index=sElpizoJump; image_index=0}
      }
    }
    else //---------- Desperation attack ----------
    {
      specProg+=1
      if specProg=2 //Init attack
      {
        playSound(global.snd_Transition,0,1,18000)
        sprite_index=sElpizoPortalLaunch
        myHS.bCanTakeDamage=0
        bCanDealDamage=0
        specHP=15
        currHspd=0; currVspd=0
      }
      else if specProg>=15 and specProg<=69 //Shake
      {
        if specProg mod 2=0 {x-=1}
        else {x+=1}
      }
      else if specProg=70
      {
        for(i=0;i<150;i+=1)
        {
          var tEffect,tRan;
          tRan=random_range(-4,4)
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sE_Ef_ASPart; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_angle=choose(0,90,180,270)
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.1
          tEffect.direction=random(360); tEffect.speed=2+random(5)
        }
        for(i=0;i<4;i+=1)
        {
          mySpecBall[i]=instance_create(x,y,oElpizoSpecBall)
          mySpecBall[i].shotTime=i*50
        }
      }
      else if specProg>=71 //Sequence
      {
        if myHS.life<myHS.maxLife
        {
          if oGame.time mod 2=0 {myHS.life+=1}
        }
        specDir+=3
        for(i=0;i<4;i+=1)
        {
          mySpecBall[i].x=x+lengthdir_x(80,specDir+(i*90))
          mySpecBall[i].y=y+lengthdir_y(80,specDir+(i*90))
        }

        //Movement
        xPoint=oPlayer1.x
        yPoint=returnPlayerYCenter()

        if x>xPoint
        {
          if currHspd>-maxSpeed {currHspd-=0.05}
          else {currHspd+=0.05}
        }
        else if x<xPoint
        {
          if currHspd<maxSpeed {currHspd+=0.05}
          else {currHspd-=0.05}
        }
        if y>yPoint
        {
          if currVspd>-maxSpeed {currVspd-=0.05}
          else {currVspd+=0.05}
        }
        else if y<yPoint
        {
          if currVspd<maxSpeed {currVspd+=0.05}
          else {currVspd-=0.05}
        }
        hspeed=currHspd; vspeed=currVspd

        if specHP<=0 //End desperation attack
        {
          hspeed=0; vspeed=0
          xVel=0
          with oElpizoSpecBall {instance_destroy()}
          with oAuraSnake {instance_destroy()}
          sprite_index=sElpizoIdle
          myHS.bCanTakeDamage=1
          bCanDealDamage=1
          actNoTele=10
          specTime=0; specProg=0
        }
      }

      if specProg=85
      {
        var tNewSnake;
        tNewSnake=instance_create(x,y,oAuraSnake)
      }
    }

    //Create Nightmare Zones
    if nightmareZoneA>=0
    {
      nightmareZoneA+=1
      if nightmareZoneA=1
      {
        nZone1=instance_create(448,288,oNightmareEffect)
        nZone1.bShifting=0; nZone1.image_xscale=2; nZone1.image_yscale=2
      }
      else if nightmareZoneA>=2
      {
        nZone1.x-=1; nZone1.y-=1
        nZone1.image_xscale+=2; nZone1.image_yscale+=2
        if nZone1.image_xscale>=64 {nightmareZoneA=-1}
      }
    }
    if nightmareZoneB>=0
    {
      nightmareZoneB+=1
      if nightmareZoneB=1
      {
        nZone2=instance_create(272,384,oNightmareEffect)
        nZone2.bShifting=0; nZone2.image_xscale=2; nZone2.image_yscale=2
        nZone3=instance_create(624,384,oNightmareEffect)
        nZone3.bShifting=0; nZone3.image_xscale=2; nZone3.image_yscale=2
      }
      else if nightmareZoneB>=2
      {
        nZone2.x-=1; nZone2.y-=1
        nZone2.image_xscale+=2; nZone2.image_yscale+=2
        nZone3.x-=1; nZone3.y-=1
        nZone3.image_xscale+=2; nZone3.image_yscale+=2
        if nZone2.image_xscale>=64 {nightmareZoneB=-1}
      }
    }
    if nightmareZoneC>=0
    {
      nightmareZoneC+=1
      if nightmareZoneC=1
      {
        nZone4=instance_create(304,144,oNightmareEffect)
        nZone4.bShifting=0; nZone4.image_xscale=2; nZone4.image_yscale=2
        nZone5=instance_create(592,144,oNightmareEffect)
        nZone5.bShifting=0; nZone5.image_xscale=2; nZone5.image_yscale=2
      }
      else if nightmareZoneC>=2
      {
        nZone4.x-=1; nZone4.y-=1
        nZone4.image_xscale+=2; nZone4.image_yscale+=2
        nZone5.x-=1; nZone5.y-=1
        nZone5.image_xscale+=2; nZone5.image_yscale+=2
        if nZone4.image_xscale>=64 {nightmareZoneC=-1}
      }
    }
    if nightmareZoneD>=0
    {
      nightmareZoneD+=1
      if nightmareZoneD=1
      {
        nZoneFind=instance_create(448,208,oElpizoNZone)
        nZoneFind.bShifting=0; nZoneFind.image_xscale=2; nZoneFind.image_yscale=2
      }
      else if nightmareZoneD>=2
      {
        nZoneFind.x-=1; nZoneFind.y-=1
        nZoneFind.image_xscale+=2; nZoneFind.image_yscale+=2
        if nZoneFind.image_xscale>=64 {nZoneFind.bSeeking=1; nightmareZoneD=-1}
      }
    }

    if specProg=0
    {
      yVel+=0.4

      if isCollisionBottom(1)
      {
        yVel=0
        if sprite_index=sElpizoIdle {xVel=0}
        if sprite_index=sElpizoJump
        {
          xVel=0
          if y>=352
          {
            if random(10)<=chargeArc
            {
              sprite_index=sElpizoFastSlashesA
              actNoTele+=teleInc; currentAction=20; attackDelay=9
            }
            else
            {
              sprite_index=sElpizoIdle
              actNoTele+=teleInc; currentAction=0; attackDelay=0
            }
          }
          else
          {
            sprite_index=sElpizoIdle
            actNoTele+=teleInc; currentAction=0; attackDelay=0
          }
        }
      }
      if isCollisionLeft(1)
      {
        x+=2
        if sprite_index=sElpizoFastSlashesB {xVel=moveSpd; image_xscale=1}
        else {xVel=4}
      }
      if isCollisionRight(1)
      {
        x-=2
        if sprite_index=sElpizoFastSlashesB {xVel=-moveSpd; image_xscale=-1}
        else {xVel=-4}
      }
      if isCollisionSolid()
      {
        if x<xCenter {x+=2}
        else {x-=2}
        if y<240 {y+=2}
        else {y-=2}
      }
      moveTo(xVel,yVel)
    }

    //---------- Boss Difficulty Curve ----------
    if myHS.lifePercent<=0.86 and myHS.lifePercent>=0.71 and bossProgress=0
    {
      waitTime-=10
      chargeArc+=1
      needleEnd+=2
      needleMod-=1
      moveSpd+=1
      bubbleDecay+=3
      portalDecay+=15
      portalArc+=0.25
      nightmareZoneA=0
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.7 and myHS.lifePercent>=0.56 and bossProgress=1
    {
      waitTime-=7
      chargeArc+=1
      needleEnd+=2
      needleMod-=1
      moveSpd+=1
      bubbleDecay+=3
      portalDecay+=15
      portalArc+=0.25
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.55 and myHS.lifePercent>=0.43 and bossProgress=2
    {
      waitTime-=7
      chargeArc+=1
      needleEnd+=4
      needleSpc-=1
      moveSpd+=1
      bubbleDecay+=3
      portalDecay+=15
      portalArc+=0.25
      nightmareZoneB=0
      nightmareZoneD=0
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.42 and myHS.lifePercent>=0.34 and bossProgress=3
    {
      waitTime-=6
      chargeArc+=1
      needleEnd+=4
      needleSpc-=1
      needleMod-=1
      moveSpd+=1
      bubbleDecay+=3
      portalDecay+=15
      portalArc+=0.25
      nightmareZoneC=0
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.33 and myHS.lifePercent>=0.26 and bossProgress=4
    {
      waitTime-=2
      timeMod=1
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.25 and myHS.lifePercent>=0 and bossProgress=5
    {
      waitTime-=6
      chargeArc+=1
      needleEnd+=2
      moveSpd+=1
      bubbleDecay+=3
      portalDecay+=15
      portalArc+=0.2
      bossProgress+=1
    }
  }
  else if myHS.life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sElpizoDefeated
      with oMisc {instance_destroy()}
      with oElpizoPortal {instance_destroy()}
      with oElpizoBubbleCon {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 9=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(25)
        global.newMapX=744; global.newMapY=1088; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        with myHS {instance_destroy()}
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(oElpizoPortal)
{
  if portalAction=1 //Turn to other side if one portal is close
  {
    var tNextPortal;
    tNextPortal=instance_nearest(x,y-22,oElpizoPortal)
    if point_distance(x,y-22,tNextPortal.x,tNextPortal.y)<=80
    {
      if x>=tNextPortal.x and image_xscale=-1 {image_xscale=1}
      else if x<=tNextPortal.x and image_xscale=1 {image_xscale=-1}
    }
  }
  else if portalAction=2 //Checks if a portal is close
  {
    var tNextPortal;
    tNextPortal=instance_nearest(x,y-22,oElpizoPortal)
    if point_distance(x,y-22,tNextPortal.x,tNextPortal.y)<=80 {portalAction=100}
  }
}
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if timeMod=1 {specTime+=5}
else {specTime+=1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,myHS.image_blend,image_alpha)

if specProg>=70
{
  if specBackAlpha=0.8 {specBackAlpha=0.6}
  else {specBackAlpha=0.8}
  draw_sprite_ext(sE_SpecialBack,image_index,x,y-20,image_xscale,image_yscale,image_angle,image_blend,specBackAlpha)
}

if activateBoss=2
{
  draw_sprite(sE_SpecBar,0,view_xview[0]+137,view_yview[0]+334)
  if specProg=0
  {
    specTrack=(specTime/specMax)*200
    if specTrack>200 {specTrack=200}
    draw_sprite_ext(sEnemyLifeTrack,0,view_xview[0]+140,view_yview[0]+337,specTrack,1.6,0,c_purple,1)
  }
  else
  {
    specTrack=(specHP/15)*200
    if specTrack>200 {specTrack=200}
    draw_sprite_ext(sEnemyLifeTrack,0,view_xview[0]+140,view_yview[0]+337,specTrack,1.6,0,c_purple,1)
  }
}

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

        attackDelay+=1*gDeltaTime
        if attackDelay>=waitTime
        {
          /*if actNoTele>=3 //Chance to teleport if he has not teleported in a few actions
          {
            if random(10)<=actNoTele {currentAction=50}
          }*/

          if currentAction=0
          {
            distanceToPlayer=point_distance(x,y,oPlayer1.x,oPlayer1.y)
            // always fixed
            if lastAction=50 and turretMode=0 // last is teleport, except when in turret mode
            {
                currentAction=40 // make a shield
            }
            else if portFlag=1
              {
                currentAction=50; portFlag=0
            }
            else if quadJump>0 // quadjump
            {
                currentAction=60
                //if quadJump=1 {currentAction=20} // end in rush
                quadJump-=1
                if quadJump=0 {currentAction=20; quadJump=-1}
            }
            /*else if doubleRush>0 // rush - shield - rush
            {
                if doubleRush mod 2 = 1 {currentAction=20}
                else {currentAction=40}
                doubleRush-=1
                if doubleRush=0 {portFlag=1}
            }*/
            /*else if turretMode>0 // double shield into danmaku
            {
                if turretMode>1 {currentAction=40}
                else {currentAction=10}
                turretMode-=1
                if turretMode=0 {portFlag=1}
            }*/
            
            /*else if lastAction=40 // last is shield
            {
                if distanceToPlayer<playerClose {currentAction=10} // danmaku if player is close
                else {currentAction=30} // else bubble
            }*/
            
            else if y<topThresh // top
            {
                /*if pain=-1 {pain=0}
                if pain>=1+bossProgress/3 //maxes out at 3 (1+2)
                {
                    currentAction=20 // rush if sufficient damage was taken at the top
                    pain=-1
                }
                else {currentAction=10} // else spam bullets
                */
                if oPlayer1.y<=y+yMercy // If player is y-close, do a rush or a jump depending on bossProgress (rush early, jump late). //TEST does this jump off?
                {
                    if bossProgress=2 {currentAction=20}
                    else {currentAction=60}
              }
              else
              {
                    directionToPlayer=point_direction(x,y,oPlayer1.x,oPlayer1.y)
                    if directionToPlayer <=270-halfAngle or directionToPlayer>=270+halfAngle {currentAction=10}
                    else {currentAction=30}
              }
            }
            else if y<midThresh // middle
            {
                /*if lastAction=60 // rush (20) or another dark jump (60)
                {
                    if jumpFlag=0
                    {
                        currentAction=20; jumpFlag+=1
                    }
                    else {currentAction=60; jumpFlag-=1}
                }
                else if oPlayer1.state>=10 and oPlayer1.state<=13 {currentAction=30; portFlag=1} // bubble into port if player is grounded
                else {currentAction=60} // dark jump if player is not grounded (and therefore vulnerable)
                */
                if bossProgress=2
                {
                    currentAction=60 // jump
                }
                else if bossProgress=3
                {
                    //turretMode here
                    if turretMode>0
                    {
                        if turretMode=1 {currentAction=40; turretMode+=1}
                        else if turretMode=2 {currentAction=40; turretMode+=1}
                        else if turretMode=3 {currentAction=10; turretMode=0}
            }
            else
            {
                        if myHS.lifePercent>0.4 {currentAction=10}
                        else if lastAction=10 {currentAction=30}
                        else {currentAction=20}
                    }
                }
                else if bossProgress=4
                {
                    currentAction=20 // rush
                }
                else {currentAction=20} //failsafe!!!
            }
            else // bottom
            {
                // check for follow-ups
                if oPlayer1.y < yGround-bubbleHeight // If player is still high up, use bubble.
                {
                    currentAction=30
                }
                else // Quad jump the first time on bossProgress 4 if the player is low.
                {
                    if bossProgress=4 and quadJump=0 {currentAction=60; quadJump=4}
                    else // Count starts at 1.
                    {
                        if bottomActCount mod 10 = 0 {currentAction=10} // Every tenth action is danmaku.
                        else if bottomActCount mod 4 = 1 {currentAction=20} // Rush -> shield -> bubble -> jump -> repeat. Danmaku takes priority.
                        else if bottomActCount mod 4 = 2 {currentAction=40}
                        else if bottomActCount mod 4 = 3 {currentAction=30}
                        else if bottomActCount mod 4 = 0 {currentAction=60}
                        
                        bottomActCount+=1
                    }
                }
            }
          }
          if currentAction=0 {currentAction=60} //Fail safe against no action taken

          lastAction=currentAction
          attackDelay=0
        }
      }
      else if currentAction>=10 and currentAction<=19 //--------------- Attack: Dark Needles ---------------
      {
        attackDelay+=1*gDeltaTime
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
            tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=13; tNewAtk.decayTime=-100; tNewAtk._direction=needleDirA
            if bossProgress>=2
            {
              tNewAtk=instance_create(x-(3*image_xscale),y-93,oPassBullet)
              tNewAtk.sprite_index=sE_DarkNeedle; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=13; tNewAtk.decayTime=-100; tNewAtk._direction=needleDirB
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
        attackDelay+=1*gDeltaTime
        if attackDelay=1 {sprite_index=sElpizoFastSlashesA} //Raise sword up
        else if attackDelay=4 {image_index=1}
        else if attackDelay=7 {image_index=2}
        else if attackDelay=10 {image_index=3}
        else if attackDelay=13 {sprite_index=sElpizoFastSlashesB; image_index=0}
        else if attackDelay>=16 and attackDelay<=61
        {
          image_index+=0.2*gDeltaTime
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
        attackDelay+=1*gDeltaTime
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
        // turretMode=3 when the second middle shield happens.
        attackDelay+=1*gDeltaTime
        if attackDelay=1 //Bring arm out
        {
            sprite_index=sElpizoPortalLaunch
            if turretMode=3 and bossProgress<4 {image_xscale*=-1} // turn around for second shield
        }
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
          if turretMode=3 and bossProgress<4 {image_xscale*=-1} // turn around again
          actNoTele+=teleInc; currentAction=0; attackDelay=0
        }
      }
      else if currentAction>=50 and currentAction<=59 //--------------- Action: Teleport ---------------
      {
        attackDelay+=1*gDeltaTime
        if attackDelay=1 {xVel=0; yVel=0; sprite_index=sElpizoTeleport}
        else if attackDelay=5 {image_index=1}
        else if attackDelay=12
        {
          playSound(global.snd_OrbThrow,0,0.98,14000)
          myHS.bCanTakeDamage=false
          bCanDealDamage=false
        }
        //else if attackDelay>=13 and attackDelay<=22 {image_alpha-=0.1*gDeltaTime}
        else if attackDelay>12 and attackDelay<=22 {image_alpha-=0.1*gDeltaTime} //60fps change: includes every frame of tick 13, so Elpizo fades fully out while teleporting (stayed at alpha 0.075 at 120fps)
        else if attackDelay=23 //Choose teleport spot
        {
          var tNextLoc;
          if oPlayer1.x >= xCenter {tNextLoc=2} else {tNextLoc=3}
          
          if bossProgress=2 {firstLoc=tNextLoc} // Save location of first port for later.
          else if bossProgress=3 {tNextLoc=1}
          else if bossProgress=4 // Use saved information and force the last port onto the unused platform.
          {
              if tNextLoc=firstLoc {if tNextLoc=2 {tNextLoc=3} else {tNextLoc=2}}
          }
          
          if tNextLoc=1 {x=448; y=272} //spsp ns adjusted before AI change
          else if tNextLoc=2 {x=256; y=176}
          else if tNextLoc=3 {x=640; y=176}
        }
        //else if attackDelay>=28 and attackDelay<=37 {image_alpha+=0.1*gDeltaTime}
        else if attackDelay>27 and attackDelay<=37 {image_alpha+=0.1*gDeltaTime} //60fps change: same for fading back in
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
        attackDelay+=1*gDeltaTime
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
          tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=15; tNewAtk.decayTime=-100; tNewAtk._direction=tDir
          if bossProgress=2 or bossProgress=3
          {
            tDir-=15
            for(i=0;i<2;i+=1)
            {
              tNewAtk=instance_create(x+(19*image_xscale),y-23,oPassBullet)
              tNewAtk.sprite_index=sE_DarkNeedle; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=15; tNewAtk.decayTime=-100; tNewAtk._direction=tDir
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
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=15; tNewAtk.decayTime=-100; tNewAtk._direction=tDir
              tDir+=17
            }
          }
        }
        if attackDelay=24
        {
            sprite_index=sElpizoJump; image_index=0
            currentAction=0; attackDelay=0
        }
      }
    }
    else //---------- Desperation attack ----------
    {
      specProg+=1*gDeltaTime
      if specProg=2 //Init attack
      {
        playSound(global.snd_Transition,0,1,18000)
        sprite_index=sElpizoPortalLaunch
        myHS.bCanTakeDamage=0
        bCanDealDamage=0
        specHP=15
        currHspd=0; currVspd=0
      }
      //else if specProg>=15 and specProg<=69 //Shake
      else if specProg>14 and specProg<=69 //Shake. 60fps change: covers every frame of ticks 15-69
      {
        //if floor(specProg) mod 2=0 {x-=1*gDeltaTime}
        if ceil(specProg) mod 2=0 {x-=1*gDeltaTime} //60fps change: ceil gives the 30fps tick number for every frame of the tick (floor was the previous tick for 3 of its 4 frames, so the shake was out of phase and ended 0.75px off)
        else {x+=1*gDeltaTime}
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
        /*if myHS.life<myHS.maxLife
        {
          if oGame.time mod (2/gDeltaTime)=0 {myHS.life+=1}
        }*/
        specDir+=3*gDeltaTime
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
          if currHspd>-maxSpeed {currHspd-=0.05*gDeltaTime}
          else {currHspd+=0.05*gDeltaTime}
        }
        else if x<xPoint
        {
          if currHspd<maxSpeed {currHspd+=0.05*gDeltaTime}
          else {currHspd-=0.05*gDeltaTime}
        }
        if y>yPoint
        {
          if currVspd>-maxSpeed {currVspd-=0.05*gDeltaTime}
          else {currVspd+=0.05*gDeltaTime}
        }
        else if y<yPoint
        {
          if currVspd<maxSpeed {currVspd+=0.05*gDeltaTime}
          else {currVspd-=0.05*gDeltaTime}
        }
        _hspeed=currHspd; _vspeed=currVspd

        if specHP<=0 //End desperation attack
        {
          _hspeed=0; _vspeed=0
          xVel=0
          with oElpizoSpecBall {instance_destroy()}
          with oAuraSnake {instance_destroy()}
          sprite_index=sElpizoIdle
          myHS.bCanTakeDamage=1
          bCanDealDamage=1
          actNoTele=10
          specTime=0; specProg=0
          //spsp ns
          myHS.life=0
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
        nZone1=instance_create(448,240,oNightmareEffect) // orig y: 288
        nZone1.bShifting=0; nZone1.image_xscale=2; nZone1.image_yscale=2
      }
      else if nightmareZoneA>=2
      {
        nZone1.x-=1*gDeltaTime; nZone1.y-=1*gDeltaTime
        nZone1.image_xscale+=2*gDeltaTime; nZone1.image_yscale+=2*gDeltaTime
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
        nZone2.x-=1*gDeltaTime; nZone2.y-=1*gDeltaTime
        nZone2.image_xscale+=2*gDeltaTime; nZone2.image_yscale+=2*gDeltaTime
        nZone3.x-=1*gDeltaTime; nZone3.y-=1*gDeltaTime
        nZone3.image_xscale+=2*gDeltaTime; nZone3.image_yscale+=2*gDeltaTime
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
        nZone4.x-=1*gDeltaTime; nZone4.y-=1*gDeltaTime
        nZone4.image_xscale+=2*gDeltaTime; nZone4.image_yscale+=2*gDeltaTime
        nZone5.x-=1*gDeltaTime; nZone5.y-=1*gDeltaTime
        nZone5.image_xscale+=2*gDeltaTime; nZone5.image_yscale+=2*gDeltaTime
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
        nZoneFind.x-=1*gDeltaTime; nZoneFind.y-=1*gDeltaTime
        nZoneFind.image_xscale+=2*gDeltaTime; nZoneFind.image_yscale+=2*gDeltaTime
        if nZoneFind.image_xscale>=64 {nZoneFind.bSeeking=1; nightmareZoneD=-1}
      }
    }

    if specProg=0
    {
      yVel=scrGravAcc(yVel,0.4,1)

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
      moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    }

    //---------- Boss Difficulty Curve ----------
    if myHS.lifePercent<=1 and bossProgress=0
    {
      // original waitTime reduction for the first four changes: 10, 7, 7, 6
      waitTime-=5
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
    else if myHS.lifePercent<=threshOne and bossProgress=1
    {
      portFlag=1
      
      waitTime-=5
      chargeArc+=1
      needleEnd+=2
      needleMod-=1
      moveSpd+=1
      bubbleDecay+=3
      portalDecay+=15
      portalArc+=0.25
      bossProgress+=1
    }
    else if myHS.lifePercent<=threshTwo and bossProgress=2
    {
      portFlag=1
      turretMode=1
      
      waitTime-=5
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
    else if myHS.lifePercent<=threshThree and bossProgress=3
    {
      /*var tAtkShield;
      for(i=0;i<6;i+=1)
      {
        tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
        tAtkShield.xOffset=16*cos(60*i); tAtkShield.yOffset=16*sin(60*i); tAtkShield.atkType=i; tAtkShield.atkUp=1
        resType[i]-=1
      }*/
      
      for(i=0;i<6;i+=1) {resType[i]-=1; myHS.resType[i]-=1}
      
      portFlag=1
      
      waitTime-=5
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
      
      waitTime-=2
      timeMod=1
      
      waitTime-=6
      chargeArc+=1
      needleEnd+=2
      moveSpd+=1
      bubbleDecay+=3
      portalDecay+=15
      portalArc+=0.2
    }
    /*else if myHS.lifePercent<=0.33 and myHS.lifePercent>=0.26 and bossProgress=4
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
    }*/
  }
  else if myHS.life<=0 //Defeat animation
  {
    if bossProgress=4
    {
        myHS.life=1
        specTime=specMax
        /*var tAtkShield;
        for(i=0;i<6;i+=1)
        {
          tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
          tAtkShield.xOffset=16*cos(60*i); tAtkShield.yOffset=16*sin(60*i); tAtkShield.atkType=i; tAtkShield.atkUp=1
          resType[i]=1
        }*/
      bossProgress+=1
    }
    else // After super mode is over, pizza really dies.
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      sprite_index=sElpizoDefeated
      with oMisc {instance_destroy()}
      with oElpizoPortal {instance_destroy()}
      with oElpizoBubbleCon {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
    }
    //else if deathAnim>=2 and deathAnim<=90
    else if deathAnim>1 and deathAnim<=90 //60fps change: includes every frame of tick 2, not just its last one
    {
      if deathAnim mod 9=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod (3/gDeltaTime)=0
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
  }
  enemyStepEvent()
}
else {_hspeed=0; _vspeed=0}

correctHSpeedVSpeed(self)

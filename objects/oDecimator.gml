#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Decimator 10000"
eLevel=37
maxLife=10000
life=maxLife
atkPower=10
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
moveWave=pi/2
bWave=0
bossPhase=0
phaseTime=0
xSpd=0; ySpd=0

bounceTime=0
bounceMod=10
specialAbility=1
specTime=0
lifeCount=-10000
lifeGainMod=10
laserPadMoveWave=0
protectorDist=64
bGuns=0
gunAngleA=0; gunAngleB=0
gunShotTime=0
gunShotDelay=120
gunA_Blend=c_white
gunB_Blend=c_white
otherShot=0
otherDelay=250

//--------------------

//Misc Data
xCenter=320
yGround=512
roomSpan=256
yCenter=320

deathAnim=0
endSeq=0
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
    jeremyText="Oh wow, this thing has a ton of weapons. CHAOS must have done a lot to get this thing working like this. Luckily this thing follows a loop. It'll always start with those bouncing metal balls, then follow up with homing missiles. Now here's where things get tricky. I can't view anymore data on it, but it looks like it summons up something after this. If you can scan that, I should have more info on it."
    chaoText="It's the machine Robotnic used in the Sonic games. I bet CHAOS has it utilizing a lot of Robotnic's attacks. Ooh wait, this is what used that laser on Pete from earlier. You'll need to watch out for that if it decides to use it on you too. Also, it... speaks French?"
    devText="This is one of those bosses I had been looking forward to making for a long while. Like always, originally it was going to have a lot more attacks, but that seemed unnecessarily complicated for the player. Instead I focused on a few that I felt had more significance."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bWave=1
    {
      moveWave+=pi/60
      y+=sin(moveWave)
    }

    if bossPhase=0 //Starting movement
    {
      x+=2
      if x>=192
      {
        xx=x; yy=y
        bWave=1
        bounceTime=8; bossPhase=1
      }
    }
    else if bossPhase=1 //Fly across room and drop Bounce Balls
    {
      x+=4
      bounceTime+=1
      if bounceTime mod bounceMod=0
      {
        tNewAttack=instance_create(x,y+24,oDeci_BounceBall)
        tNewAttack.atkPower=atkPower; tNewAttack.yVel=-4
        tNewAttack.xVel=3*image_xscale; tNewAttack.xFalloff=0.001
      }

      if x>=512
      {
        image_xscale=-1
        bounceTime=0; bossPhase=2
      }
    }
    else if bossPhase=2 //Idle
    {
      bounceTime+=1
      if bounceTime>=40 {bounceTime=10; bossPhase=3}
    }
    else if bossPhase=3 //Fly toward middle of room, launching Missiles
    {
      x-=3
      bounceTime+=1
      if bounceTime mod bounceMod+2=0
      {
        var tMissile;
        tMissile=instance_create(x,y-16,oHomingMissile)
        tMissile.atkPower=atkPower; tMissile.targetTime=20; tMissile.sprite_index=sDeci_Missile
        tMissile.bulletSpeed=4; tMissile.seekThres=20; tMissile.minSpd=3; tMissile.maxSpd=8
        tMissile.turnSpd=4; tMissile.accel=0.2; tMissile.direction=90
      }

      if x<=xCenter
      {
        bounceTime=0; bossPhase=4
      }
    }
    else if bossPhase=4 //Idle
    {
      bounceTime+=1
      if bounceTime>=40
      {
        xSpd=0; ySpd=0
        otherShot=70
        bounceTime=0; bossPhase=5
      }
    }
    else if bossPhase=5 //Execute special ability
    {
      if oGame.time mod lifeGainMod=0 //HP Regen
      {
        life+=2
        if life>maxLife {life=maxLife}
      }
      specTime+=1
      if specialAbility=1 //---------- Laser Pads ----------
      {
        if specTime=1
        {
          playSound(global.snd_VO_Dec_01,0,1,1)
          laserPadMoveWave=0
          lifeGainMod=2
          lifeCount=life
          bWave=0
          var tLaserPad;
          for(i=0;i<5;i+=1)
          {
            tLaserPad=instance_create(x,y+28+(i*40),oDeciLaserPad)
            tLaserPad.type=i
            tLaserPad.turnSpd=0.13-(0.01*i)
            tLaserPad.bFollow=1; tLaserPad.idFollow=id; tLaserPad.xFollow=0; tLaserPad.yFollow=28+(i*40)
            if i mod 2=0 {tLaserPad.x-=64}
            else {tLaserPad.x+=64}
          }
        }
        else if specTime>=10
        {
          if !instance_exists(oDeciLaserPad)
          {
            bWave=0
            bossPhase=6
          }
        }

        if specTime>=45 //Wave left and right
        {
          laserPadMoveWave+=pi/100
          x+=cos(laserPadMoveWave)*3

          if specTime mod 5=0 //If player is above Decimator
          {
            if oPlayer1.y<=y-24
            {
              var tNewAttack;
              tNewAttack=instance_create(x,y,oPassBullet)
              tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=10
              tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
            }
          }
        }
      }
      else if specialAbility=2 //---------- Armor ----------
      {
        if specTime=1
        {
          playSound(global.snd_VO_Dec_02,0,1,1)
          xSpd=0
          lifeGainMod=4
          lifeCount=life
          bWave=0
          bCanBeScanned=0
          var tArmor;
          tArmor=instance_create(x,y,oDeciArmor)
          tArmor.bFollow=1; tArmor.idFollow=id; tArmor.xFollow=0; tArmor.yFollow=0
        }
        else if specTime>=10
        {
          if !instance_exists(oDeciArmor)
          {
            bCanBeScanned=1
            bCanTakeDamage=true; bCanDealDamage=true
            bWave=0
            bossPhase=6
          }
        }

        if specTime>=45 //Follow player x
        {
          if x<oPlayer1.x {if xSpd<3 {xSpd+=0.075}}
          else {if xSpd>-3 {xSpd-=0.075}}
          x+=xSpd
        }
      }
      else if specialAbility=3 //---------- Protectors ----------
      {
        if specTime=1
        {
          playSound(global.snd_VO_Dec_03,0,1,1)
          lifeGainMod=1
          lifeCount=life
          bWave=0
          var tProtector;
          for(i=0;i<8;i+=1)
          {
            tProtector=instance_create(x,y,oDeciProtector)
            tProtector.type=i; tProtector.shotTime=i*70; tProtector.myDir=i*45
          }
        }
        else if specTime>=10
        {
          if !instance_exists(oDeciProtector)
          {
            bWave=0
            bossPhase=6
          }
        }

        if specTime>=45 //Follow player
        {
          if x<oPlayer1.x {if xSpd<1.5 {xSpd+=0.04}}
          else {if xSpd>-1.5 {xSpd-=0.04}}
          x+=xSpd

          if y<returnPlayerYCenter() {if ySpd<1.5 {ySpd+=0.4}}
          else {if ySpd>-1.5 {ySpd-=0.04}}
          y+=ySpd

          if xSpd>0 {image_xscale=1}
          else {image_xscale=-1}
        }
      }

      //Missiles from the skies
      otherShot+=1
      if otherShot>=otherDelay and otherShot<=otherDelay+100
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        otherShot=1000
      }
      else if otherShot>=1031 and otherShot<=1060
      {
        if otherShot mod 3=0
        {
          playSound(global.snd_BombLaunch,0,0.9,60000)
          var tNewAttack;
          tNewAttack=instance_create(x+random_range(-6,6),y-6,oPassBullet)
          tNewAttack.sprite_index=sDeci_Missile; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
          tNewAttack.decayTime=-100; tNewAttack.direction=88+random(4)
        }
      }
      else if otherShot>=1080 and otherShot<=1140
      {
        if otherShot mod 20=0
        {
          var tNewAttack;
          tNewAttack=instance_create(oPlayer1.x,4,oPassBullet)
          tNewAttack.sprite_index=sDeci_Missile; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=10
          tNewAttack.decayTime=-100; tNewAttack.direction=270
          tNewAttack=instance_create(oPlayer1.x+56,4,oPassBullet)
          tNewAttack.sprite_index=sDeci_Missile; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
          tNewAttack.decayTime=-100; tNewAttack.direction=267
          tNewAttack=instance_create(oPlayer1.x-56,4,oPassBullet)
          tNewAttack.sprite_index=sDeci_Missile; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
          tNewAttack.decayTime=-100; tNewAttack.direction=273
        }
      }
      else if otherShot>=1151 {otherShot=0}
    }
    else if bossPhase=6 //Fly to left side of the room (Where it started)
    {
      if bounceTime=0
      {
        playSound(global.snd_BombExplode,0,0.92,35000)
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        life-=1500
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        bounceTime=1
      }

      if x>xx+2 {x-=2; image_xscale=-1}
      else if x<xx-2 {x+=2; image_xscale=1}

      if y>yy+2 {y-=2}
      else if y<yy-2 {y+=2}

      if point_distance(x,y,xx,yy)<3
      {
        specialAbility+=1
        if specialAbility=4 {specialAbility=1}
        specTime=0
        bWave=1
        image_xscale=1
        bossPhase=7
      }
    }
    else if bossPhase=7 //Idle
    {
      bounceTime+=1
      if bounceTime>=40 {bounceTime=0; bossPhase=1}
    }

    if bGuns=1 //Twin guns
    {
      gunAngleA=point_direction(x+18,y+6,oPlayer1.x,returnPlayerYCenter())
      gunAngleB=point_direction(x-18,y+6,oPlayer1.x,returnPlayerYCenter())
      gunShotTime+=1
      if gunShotTime=gunShotDelay-20 {gunA_Blend=c_maroon}
      else if gunShotTime=gunShotDelay
      {
        playSound(global.snd_CShotB,0,0.9,60000)
        gunA_Blend=c_white
        var tNewAttack;
        tNewAttack=instance_create(x+18,y+6,oPassBullet)
        tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=gunAngleA
      }
      else if gunShotTime=(gunShotDelay*2)-20 {gunB_Blend=c_maroon}
      else if gunShotTime>=gunShotDelay*2
      {
        playSound(global.snd_CShotB,0,0.9,60000)
        gunB_Blend=c_white
        var tNewAttack;
        tNewAttack=instance_create(x-18,y+6,oPassBullet)
        tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=gunAngleB
        gunShotTime=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.5 and lifePercent>=0 and bossProgress=0
    {
      bounceMod-=2
      otherDelay-=20
      bGuns=1
      bossProgress+=1
    }
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim=1
  {
    if global.bBossGallery=1
    {
      bossRoomTally(55)
      global.newMapX=360; global.newMapY=352; room_goto(rBossGallery)
    }
    else
    {
      bGuns=0
      bCanTakeDamage=false; bCanDealDamage=false
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
      with oDeciLaserPad {instance_destroy()}
      with oDeciArmor {instance_destroy()}
      with oDeciProtector {instance_destroy()}
      global.gamePaused=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.visible=0; oPlayer1.x=xCenter; oPlayer1.y=320
      x=xCenter; y=304

      mashingButtons=instance_create(0,0,oMashButtons)
      mashingButtons.xCenter=xCenter; mashingButtons.yCenter=304
      mashingButtons.startJerryX=xCenter+128; mashingButtons.startJerryY=304
      mashingButtons.startClaireX=xCenter-128; mashingButtons.startClaireY=304
    }
  }
  else if deathAnim=15
  {
    msgCreate(0,0,"Claire","This thing is annoying!!",0,0,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if deathAnim=80
  {
    msgCreate(0,0,"Jerry","Whoa, what?!",0,0,oMessagePerson,0)
    newMessage.fadingTime=50
    tile_layer_show(999989)
    var tColl;
    tColl=instance_create(64,464,oInvisibleSolid); tColl.image_xscale=32
    with mashingButtons {instance_destroy()}
    with oMisc {instance_destroy()}
    oPlayer1.visible=1
    image_blend=baseColor
    image_xscale=1
    global.gamePaused=false
  }
  else if deathAnim>=81
  {
    var tAfterI;
    tAfterI=instance_create(x,y,oEnemyAfterImage)
    tAfterI.sprite_index=sprite_index; tAfterI.image_blend=c_green
    tAfterI.image_alpha=0.5; tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.05
    tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0; tAfterI.bFollow=0
    x+=8
    if endSeq=0
    {
      if x>=544
      {
        with (426628) {instance_destroy()}
        tile_layer_hide(999990)
        playSound(global.snd_BombExplode,0,1,15000)
        for(i=0;i<96;i+=1)
        {
          tEffect=instance_create(608+random_range(-24,24),96+random(512),oEffect)
          tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.33
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        endSeq=1
      }
    }
    else if endSeq=1
    {
      if x>=688
      {
        oPlayer1.life=oPlayer1.maxLife
        global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
        global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)
        global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
        global.hudMega_BusterEn[0]=32
        global.hudMega_ShotIceEn[0]=32
        global.hudMega_GravityEn[0]=32
        global.hudSamus_CannonEn[0]=0
        global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
        global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
        boss=instance_create(960,224,oDecimatorV2)
        boss.activateBoss=1; boss.prefight=0
        storeStatus(0)
        global.bossTrack=2
        oRm_MC_Camera.progress=1
        instance_create(0,0,oCheckpointNotice)
        instance_destroy()
      }
    }
  }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bossPhase=5
{
  if life<lifeCount-1000
  {
    for(i=0;i<6;i+=1)
    {
      resType[i]=1
    }
    lifeCount=-10000
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if bGuns=1
{
  draw_sprite_ext(sDeciGun,0,x+18,y+6,1,1,gunAngleA,gunA_Blend,image_alpha)
  draw_sprite_ext(sDeciGun,0,x-18,y+6,1,1,gunAngleB,gunB_Blend,image_alpha)
}

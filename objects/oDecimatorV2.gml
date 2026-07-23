#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
image_xscale=-1

//Enemy base statistics
eName="Decimator 20000"
eLevel=37
maxLife=20000
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
firstPhaseTime=0
progTime=0
regenRate=3

moveWave=pi/2
bWave=0
ySpd=0

bGuns=0
gunAngleA=0; gunAngleB=0
gunShotTime=0
gunShotDelay=90
gunA_Blend=c_white
gunB_Blend=c_white

laserSpamTime=0
laserSpamDelay=180
shotDir=0
bMissiles=0
missileTime=0
missileDelay=270

bCanUseCannon=0
bLaserCannon=0
cannonBlend=c_white
laserCannonTime=40
laserCannonDelay=240
bAimAtJohn=0

energyBallTime=0
energyBallMod=90
rapidFire=0
//--------------------

//Misc Data
xCenter=928
yCenter=224

deathAnim=0
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
    jeremyText="So apparently destroying the Decimator 10000 causes it to upgrade to the Decimator 20000. Huh, who knew? Anyway, this thing is going to start going crazy with its lasers. It has also gained an extremely crazy regeneration rate. I'm not sure how you're going to keep up with that."
    chaoText="That lightning rod can't be destroyed since it doesn't have a hitbox, so I don't see a way to disable its regeneration. Maybe if it goes to a low enough percentage? Hmm, I'm not sure about that either since you're forced on the defensive for a long time due to that laser spam."
    devText="In a game made before DT, there was a multi-part boss fight that played out a bit like this. I've been wanting to revisit that idea again, so here we go."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //HP Regen
    life+=regenRate
    if life>maxLife {life=maxLife}

    if bWave=1
    {
      moveWave+=pi/50
      y+=sin(moveWave)/2
    }

    if bossProgress=0 //---------- Wait till player approaches ----------
    {
      if oPlayer1.x>=816
      {
        bWave=1
        bCanTakeDamage=true
        if prefight=0 {oRm_MC_Camera.progress=2}
        if prefight=1 //If checkpoint had been reached
        {
          firstPhaseTime=999
        }
        bossProgress+=1
      }
    }
    else if bossProgress=1 //---------- Before John shows up ----------
    {
      laserSpamTime+=1
      if laserSpamTime>=laserSpamDelay
      {
        playSound(global.snd_CShotB,0,0.9,60000)
        var tNewAttack;
        shotDir+=8
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=shotDir
        tNewAttack=instance_create(x,y,oPassBulletRed)
        tNewAttack.sprite_index=sDeci_SmallLaserRed; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=shotDir+180
        if laserSpamTime>=laserSpamDelay+90 {shotDir=0; laserSpamTime=0}
      }

      missileTime+=1
      if missileTime>=missileDelay
      {
        var tMissile;
        tMissile=instance_create(x,y-16,oHomingMissile)
        tMissile.atkPower=atkPower; tMissile.targetTime=20; tMissile.sprite_index=sDeci_Missile
        tMissile.bulletSpeed=4; tMissile.seekThres=20; tMissile.minSpd=3; tMissile.maxSpd=7
        tMissile.turnSpd=3; tMissile.accel=0.3; tMissile.direction=90
        missileTime=0
      }

      firstPhaseTime+=1
      if firstPhaseTime=840
      {
        msgCreate(0,0,"Claire","We're not getting anywhere with this thing.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if firstPhaseTime=920
      {
        msgCreate(0,0,"Jerry","That regen hurts.",0,1,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if firstPhaseTime>=1000 //John appears
      {
        if prefight=0
        {
          instance_create(0,0,oCheckpointNotice)
          global.bossTrack=3
        }
        var myJohn;
        myJohn=instance_create(688,0,oJohnMech)
        myJohn.prefight=prefight
        missileTime=0
        bGuns=1
        bossProgress+=1
      }
    }
    else if bossProgress=3 //---------- Player is assisted by John's mech ----------
    {
      //Follow player y
      if laserCannonTime<=laserCannonDelay+69
      {
        if y>oPlayer1.y-26 {if ySpd>-4 {ySpd-=0.4}}
        else if y<oPlayer1.y-26 {if ySpd<4 {ySpd+=0.4}}
        y+=ySpd
      }
    }
    else if bossProgress=4 //---------- Shoot at John's mech ----------
    {
      progTime+=1
      if progTime=20
      {
        bAimAtJohn=1
        gunA_Blend=c_maroon
        gunB_Blend=c_maroon
      }
      else if progTime>=21
      {
        gunAngleA=point_direction(x+18,y+6,oJohnMech.x,oJohnMech.y-32)
        gunAngleB=point_direction(x-18,y+6,oJohnMech.x,oJohnMech.y-32)
      }

      if progTime>=50
      {
        if progTime mod 3=0
        {
          playSound(global.snd_CShotB,0,0.9,60000)
          var tNewAttack;
          tNewAttack=instance_create(x+18,y+6,oPassBullet)
          tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack.direction=gunAngleA+random_range(-2,2)
          tNewAttack=instance_create(x-18,y+6,oPassBullet)
          tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack.direction=gunAngleB+random_range(-2,2)
        }
      }

      if progTime>=100
      {
        gunA_Blend=c_white
        gunB_Blend=c_white
      }
    }
    else if bossProgress>=6 and bossProgress<=7 //---------- Shoot at player and John ----------
    {
      //Follow player y
      if laserCannonTime<=laserCannonDelay+69
      {
        if y>oPlayer1.y-26 {if ySpd>-4 {ySpd-=0.4}}
        else if y<oPlayer1.y-26 {if ySpd<4 {ySpd+=0.4}}
        y+=ySpd
      }

      energyBallTime+=1
      if energyBallTime mod energyBallMod=0
      {
        playSound(global.snd_CShotA,0,0.9,18000)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oDeci_EnergyBall)
        tNewAttack.bulletSpeed=5
        tNewAttack.direction=point_direction(x,y,oJohnMech.x,oJohnMech.y-32)
      }

      rapidFire+=1
      if rapidFire=180
      {
        if bossProgress=6 {energyBallMod=10}
        else {energyBallMod=6}
      }
      else if rapidFire=220
      {
        if bossProgress=6 {energyBallMod=90}
        else {energyBallMod=60}
        rapidFire=0
      }
    }

    if bGuns=1 and bossProgress!=4 //Twin guns
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

    if bMissiles=1 //Missile Spray
    {
      missileTime+=1
      if missileTime>=missileDelay
      {
        var tMissile;
        for(i=0;i<5;i+=1)
        {
          tMissile=instance_create(x,y-16,oHomingMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=35+(i+3); tMissile.sprite_index=sDeci_Missile
          tMissile.bulletSpeed=1.5; tMissile.seekThres=20; tMissile.minSpd=3; tMissile.maxSpd=7
          tMissile.turnSpd=3; tMissile.accel=0.3; tMissile.direction=25-(12.5*i)
        }
        missileTime=0
      }
    }

    if bCanUseCannon=1 //Big Laser Cannon
    {
      laserCannonTime+=1
      if laserCannonTime>=laserCannonDelay
      {
        if oGame.time mod 2=0
        {
          if cannonBlend=c_white {cannonBlend=c_red}
          else {cannonBlend=c_white}
        }
        if laserCannonTime=laserCannonDelay+1 {playSound(global.snd_Dec_ChargeUp,0,1,1)}
        if laserCannonTime=laserCannonDelay+70
        {
          ySpd=0
          playSound(global.snd_Dec_Fire,0,1,1)
          myLaser=instance_create(576,y,oDeci_BigLaser)
        }
        else if laserCannonTime>=laserCannonDelay+71 and laserCannonTime<=laserCannonDelay+115
        {
          myLaser.y=y+16
        }
        else if laserCannonTime>=laserCannonDelay+116
        {
          with oDeci_BigLaser {instance_destroy()}
          cannonBlend=c_white
          laserCannonTime=0
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.5 and lifePercent>=0 and bossProgress=3
    {
      if laserCannonTime<laserCannonDelay
      {
        bCanUseCannon=0
        laserCannonTime=0
        bossProgress+=1
      }
    }
    else if lifePercent<=0.33 and lifePercent>=0 and bossProgress=6
    {
      missileDelay-=15
      energyBallMod=60
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
    with oEProjectileBase {instance_destroy()}
    with oAttackBase {instance_destroy()}
  }
  else if deathAnim>=2 and deathAnim<=60
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod 2=0
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-sprite_width,sprite_width),y+random_range(-sprite_height,sprite_height),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>=61
  {
    if global.bBossGallery=1
    {
      bossRoomTally(56)
      global.newMapX=504; global.newMapY=352; room_goto(rBossGallery)
    }
    else
    {
      oJohnMech.progress=7
      oEvCh19MainA.sceneProgress=1
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bLaserCannon=1
{
  draw_sprite_ext(sDeciLaserCannon,0,x+4,y+12,-1,1,image_angle,cannonBlend,image_alpha)
}
event_inherited()
draw_sprite_ext(sDeciLightningRod,0,x,y+40,1,1,image_angle,image_blend,image_alpha)

if bGuns=1
{
  draw_sprite_ext(sDeciGun,0,x+18,y+6,1,1,gunAngleA,gunA_Blend,image_alpha)
  draw_sprite_ext(sDeciGun,0,x-18,y+6,1,1,gunAngleB,gunB_Blend,image_alpha)
}

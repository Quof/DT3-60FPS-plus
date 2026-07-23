#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-0.85
image_yscale=0.85
image_speed=0.15
//visible=0
facing=-1

//Enemy base statistics
eName="Nightmare"
eLevel=26
maxLife=2700
life=maxLife
atkPower=9
resType[0]=2
resType[1]=2
resType[4]=1
resType[5]=4
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
faceImage=-1
bWave=1
moveWaveY=pi/2
bGravExist=0
gravTime=0
gravDelay=900

moveBehavior=0
moveTime=0
xSpd=0; ySpd=0
maxSpd=7

gunShotTime=100
gunShotDelay=140
gunX=0; gunY=0
spamGunTime=160
spamGunDelay=280
spamGunDuration=45

//Misc Data
xCenter=272
yGround=432
roomSpan=208

deathAnim=0

myBody=instance_create(x,y,oNightmareParts)
myBody.sprite_index=sMetNightmareBody; myBody.depth=7
myRightArm=instance_create(x,y,oNightmareParts)
myRightArm.sprite_index=sMetNightmareRightArm; myRightArm.depth=8
myLeftArm=instance_create(x,y,oNightmareParts)
myLeftArm.sprite_index=sMetNightmareLeftArm; myLeftArm.depth=6

jeremyText="Oh wow, this is gonna be a tough one. It doesn't have many attacks, but what it does have are very effective. The big one to watch for is the laser spam, which you'll need to lead. There's a nasty sound you'll periodically hear, when you do, he's summoning up a high-gravity device. This is dangerous when Nightmare is tracking you around the room. Like the lasers, lead him away to give yourself an opening."
chaoText="This is a Bio-Mechanical organism designed for military applications that possesses uncommon power and can manipulate gravity, at least according to the original game. He's protected by some weird armor. You're going to need something to either pierce through it or something that has splash damage."
devText="I originally had plans for 2 other attacks for Nightmare, but when seeing how effective he was in the state he is now, I saw there was no need for anything else."
with oNightmareParts
{
  jeremyText=oMetNightmare.jeremyText
  chaoText=oMetNightmare.chaoText
  devText=oMetNightmare.devText
}
instance_create(272,oPlayer1.y,oGateF_BossCamera)
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
    if bWave=1
    {
      moveWaveY+=0.05
      y+=sin(moveWaveY)
    }

    moveTime+=1
    if moveBehavior=0 //idle
    {
      if moveTime>=360
      {
        gunShotTime=0
        moveBehavior+=1
        bWave=0
        moveTime=0
      }
    }
    else if moveBehavior=1 //move warn
    {
      if moveTime>=25
      {
        moveBehavior+=1
        moveTime=0
      }
    }
    else if moveBehavior=2 //fly around room with fixation on player
    {
      if x>oPlayer1.x
      {
        if xSpd>-maxSpd {xSpd-=0.2}
      }
      else if x<oPlayer1.x
      {
        if xSpd<maxSpd {xSpd+=0.2}
      }
      if y>oPlayer1.y-26
      {
        if ySpd>-maxSpd {ySpd-=0.2}
      }
      else if y<oPlayer1.y-26
      {
        if ySpd<maxSpd {ySpd+=0.2}
      }
      x+=xSpd; y+=ySpd

      if moveTime>=360
      {
        xSpd=0; ySpd=0
        moveBehavior+=1
        moveTime=0
      }
    }
    else if moveBehavior=3 //find an idle spot
    {
      if moveTime=1
      {
        xSpd=320+irandom_range(-32,32)
        ySpd=336+irandom_range(-8,8)
      }
      else if moveTime>=25
      {
        direction=point_direction(x,y,xSpd,ySpd)
        speed=4
        if point_distance(x,y,xSpd,ySpd)<5
        {
          speed=0
          xSpd=0; ySpd=0
          moveBehavior=0
          bWave=1
          moveWaveY=pi/2
          moveTime=0
        }
      }
    }

    //-------------------- ATTACK: LINEAR GUN SHOT --------------------
    if moveBehavior=0 {gunShotTime+=1}
    if gunShotTime>=gunShotDelay and gunShotTime<=gunShotDelay+100
    {
      gunShotTime=10000
    }
    else if gunShotTime=10001 {gunX=49; gunY=6; event_user(0)}
    else if gunShotTime=10004 {gunX=51; gunY=23; event_user(0)}
    else if gunShotTime=10007 {gunX=47; gunY=39; event_user(0)}
    else if gunShotTime>=10010 {gunShotTime=0} //end attack

    //-------------------- ATTACK: SPAM GUN --------------------
    spamGunTime+=1
    if spamGunTime>=spamGunDelay and spamGunTime<=spamGunDelay+100
    {
      spamEffA=instance_create(x-(51*facing),y+23,oEffect)
      spamEffA.sprite_index=sMetNightGunEffect; spamEffA.image_xscale=2; spamEffA.image_yscale=2
      spamEffA.newBlend=1; spamEffA.decay=9000000; spamEffA.xSpd=0; spamEffA.ySpd=0; spamEffA.depth=6
      spamEffA.followID=id; spamEffA.xFollow=-51*facing; spamEffA.yFollow=23
      spamEffB=instance_create(x-(18*facing),y+37,oEffect)
      spamEffB.sprite_index=sMetNightGunEffect; spamEffB.image_xscale=2; spamEffB.image_yscale=2
      spamEffB.newBlend=1; spamEffB.decay=9000000; spamEffB.xSpd=0; spamEffB.ySpd=0; spamEffB.depth=6
      spamEffB.followID=id; spamEffB.xFollow=-18*facing; spamEffB.yFollow=37
      spamGunTime=10000
    }
    else if spamGunTime=10030
    {
      with spamEffA {instance_destroy()}
      with spamEffB {instance_destroy()}
    }
    else if spamGunTime>=10030 and spamGunTime<=10030+spamGunDuration //rapid fire toward player
    {
      if spamGunTime mod 4=0
      {
        var tAtk,tRanY;
        tRanY=random_range(-15,15)
        tAtk=instance_create(x-(51*facing),y+23+tRanY,oPassBullet)
        tAtk.sprite_index=sMetNightGunEffect; tAtk.atkPower=atkPower; tAtk.bulletSpeed=5; tAtk.decayTime=-100
        tAtk.image_xscale=0.75; tAtk.image_yscale=0.75; tAtk.image_speed=0; tAtk.depth=6; tAtk.image_xscale=2; tAtk.image_yscale=0.5
        tAtk.direction=point_direction(x-(51*facing),y+23+tRanY,oPlayer1.x,oPlayer1.y-26)
        tRanY=random_range(-9,9)
        tAtk=instance_create(x-(18*facing),y+37+tRanY,oPassBullet)
        tAtk.sprite_index=sMetNightGunEffect; tAtk.atkPower=atkPower; tAtk.bulletSpeed=5; tAtk.decayTime=-100
        tAtk.image_xscale=0.75; tAtk.image_yscale=0.75; tAtk.image_speed=0; tAtk.depth=6; tAtk.image_xscale=2; tAtk.image_yscale=0.5
        tAtk.direction=point_direction(x-(18*facing),y+37+tRanY,oPlayer1.x,oPlayer1.y-26)
      }
    }
    else if spamGunTime>=10031+spamGunDuration //end attack
    {
      spamGunTime=0
    }

    //-------------------- UTILITY: CREATE GRAVITY DEVICE --------------------
    if bGravExist=0
    {
      gravTime+=1
      if gravTime>=gravDelay
      {
        myGravDev=instance_create(x,y,oNightmareParts)
        myGravDev.sprite_index=sMetNightmareGrav; myGravDev.image_alpha=0; myGravDev.depth=9
        myGravDev.jeremyText=oMetNightmare.jeremyText
        myGravDev.chaoText=oMetNightmare.chaoText
        myGravDev.devText=oMetNightmare.devText
        playSound(global.snd_SwitchHit,0,1,10000)
        gravTime=0
        bGravExist=1
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.85 and lifePercent>=0.69 and bossProgress=0
    {
      gunShotDelay-=16
      spamGunDelay-=12
      spamGunDuration+=5
      gravDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.68 and lifePercent>=0.52 and bossProgress=1
    {
      gunShotDelay-=16
      spamGunDelay-=12
      spamGunDuration+=5
      gravDelay-=15
      faceImage+=1
      var tEffect;
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(x+random_range(-22,22),y-random(48),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.depth=5; tEffect.image_speed=0.5
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.followID=-1
      }
      bossProgress+=1
    }
    else if lifePercent<=0.51 and lifePercent>=0.33 and bossProgress=2
    {
      gunShotDelay-=16
      spamGunDelay-=12
      spamGunDuration+=5
      gravDelay-=15
      faceImage+=1
      var tEffect;
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(x+random_range(-22,22),y-random(48),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.depth=5; tEffect.image_speed=0.5
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.followID=-1
      }
      bossProgress+=1
    }
    else if lifePercent<=0.32 and lifePercent>=0 and bossProgress=3
    {
      gunShotDelay-=16
      spamGunDelay-=12
      spamGunDuration+=5
      gravDelay-=15
      faceImage+=1
      var tEffect;
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(x+random_range(-22,22),y-random(48),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.depth=5; tEffect.image_speed=0.5
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.followID=-1
      }
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      bCanDealDamage=false
      with oNightmareParts {bCanDealDamage=false}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 6=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x-24+random(48),y-random(48),oEffect)
        tEffect.sprite_index=sSamusMissileHit; tEffect.image_speed=0.5; tEffect.depth=6
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(37)
        global.newMapX=2040; global.newMapY=752; room_goto(rBossGallery)
      }
      else
      {
        with oNightmareParts {instance_destroy()}
        oEvExGates.sceneProgress=1
        instance_destroy()
      }
    }
  }
}
else {speed=0}

myBody.x=x+(4*facing); myBody.y=y-27; myBody.image_xscale=facing; myBody.image_blend=image_blend
myRightArm.x=x+(22*facing); myRightArm.y=y+5; myRightArm.image_xscale=facing; myRightArm.image_blend=image_blend
myLeftArm.x=x-(38*facing); myLeftArm.y=y-29; myLeftArm.image_xscale=facing; myLeftArm.image_blend=image_blend
if bGravExist=1 {myGravDev.x=x-(42*facing); myGravDev.y=y+13; myGravDev.image_xscale=facing}

if global.gamePaused=false {enemyStepEvent()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 {redDmgHit(0)}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tEffect,tAtk;
tEffect=instance_create(x-(gunX*facing),y+gunY,oEffect)
tEffect.sprite_index=sMetNightGunEffect; tEffect.image_speed=0.5
tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=6
tEffect.followID=id; tEffect.xFollow=-gunX*facing; tEffect.yFollow=gunY

tAtk=instance_create(x-(gunX*facing),y+gunY,oPassBullet)
tAtk.sprite_index=sMetNightGunEffect; tAtk.atkPower=atkPower; tAtk.bulletSpeed=5; tAtk.decayTime=-100
tAtk.image_xscale=0.75; tAtk.image_yscale=0.75; tAtk.image_speed=0; tAtk.depth=6
if facing=1 {tAtk.direction=0}
else {tAtk.direction=180}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if faceImage=0 {draw_sprite_ext(sMetNightmareFaceA,image_index,x,y,-1,1,image_angle,image_blend,image_alpha)}
else if faceImage=1 {draw_sprite_ext(sMetNightmareFaceB,image_index,x,y,-1,1,image_angle,image_blend,image_alpha)}
else if faceImage=2 {draw_sprite_ext(sMetNightmareFaceC,image_index,x,y,-1,1,image_angle,image_blend,image_alpha)}

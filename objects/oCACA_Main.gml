#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
fingerFrm=0
animSpd=0.15
image_xscale=-1

//Enemy base statistics
eName="Advanced Combat Apparatus"
eLevel=34
maxLife=11400
life=maxLife
atkPower=9
resType[1]=1
resType[2]=2
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bossPhase=1
phaseTime=0
moveSpd=1
bChestLight=0
bFloorFlame=1

explodeMissileTime=200
explodeMissileDelay=250
explodeMissileNum=4

laserMouthTime=160
laserMouthDelay=270

laserEyeTime=130
laserEyeDelay=300
laserWarn=0
circleAlpha=0
cirRad=0

skyLaserTime=240
skyLaserDelay=330

bAtkFloorFire=0
atkFloorFireTime=340
atkFloorFireDelay=350

backMissile=0

chestLaserTime=0
hitsDuringLaser=0
bombSpacingA=75
bombSpacingB=100
bombType=0
//--------------------

//Misc Data
xCenter=624
yGround=736
roomSpan=352

deathAnim=0

var tXOff;
tXOff=-80
for(i=0;i<9;i+=1)
{
  myFloorFire[i]=instance_create(x,y,oCACA_FloorFire)
  myFloorFire[i].atkPower=atkPower; myFloorFire[i].xOffset=tXOff
  myFloorFire[i].image_speed=0.3+(0.01*i)
  tXOff+=20
}
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
    jeremyText="This thing has a lot of guns. Your safest place is on the floor, but you can't do damage very well down there. I'd say the biggest threat are those damn exploding missiles. Watch the location that they explode on and be careful of their origin. Its movement is simple, but after a complete cycle, it does something where it removes the platforms and there's a big ass laser beam."
    chaoText="This sprite is from the Sega Genesis game, 'Knuckles Chaotix'. Looks like CHAOS is using it for massive amounts of weapons. It isn't quite what I expected to be down here."
    devText="Originally I was going to call this the 'CHAOS Advanced Combat Apparatus', shortened for CACA, but I took out the CHAOS part because the name was already too long. You can still call it that though, I don't mind."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    fingerFrm+=animSpd

    //Resistance changes
    if instance_exists(oCACA_MouthLaser) {resType[3]=4}
    else {resType[3]=3}
    if laserEyeTime>=laserEyeDelay {resType[5]=4}
    else {resType[5]=3}

    phaseTime+=1
    if bossPhase=1 //---------- MOVEMENT: CIRCLE - Right side ----------
    {
      direction+=3
      x+=moveSpd*cos(degtorad(direction))
      y+=moveSpd*sin(degtorad(direction))
      if phaseTime>=490
      {
        phaseTime=0
        bossPhase+=1
      }
    }
    else if bossPhase=2 //---------- MOVEMENT: To left side ----------
    {
      if phaseTime>=40
      {
        if laserMouthTime>=laserMouthDelay {laserMouthTime=laserMouthDelay-5}
        x-=8
        if x<=432
        {
          image_xscale=1
          phaseTime=0
          bossPhase+=1
        }
      }
    }
    else if bossPhase=3 //---------- MOVEMENT: CIRCLE - Left side ----------
    {
      direction-=3
      x+=moveSpd*cos(degtorad(direction))
      y+=moveSpd*sin(degtorad(direction))
      if phaseTime>=490
      {
        if laserMouthTime>laserMouthDelay {laserMouthTime=laserMouthDelay-5}
        if explodeMissileTime>explodeMissileDelay {explodeMissileTime=explodeMissileDelay-5}
        if laserEyeTime>laserEyeDelay {laserEyeTime=laserEyeDelay-5}
        if atkFloorFireTime>atkFloorFireDelay {atkFloorFireTime=atkFloorFireDelay-5}
        laserWarn=0
        circleAlpha=0
        cirRad=0
        phaseTime=0
        bossPhase+=1
      }
    }
    else if bossPhase=4 //---------- MOVEMENT: To the left (stop at left end) and drop lower ----------
    {
      if phaseTime>=10 and phaseTime<=90
      {
        x-=8
        if x<=280
        {
          x=280
          phaseTime=100
        }
      }
      if phaseTime=101
      {
        with oBBot_FloorFlame {instance_destroy()}
        with oDummyPlat
        {
          var tEffect;
          for(i=0;i<4;i+=1)
          {
            tEffect=instance_create(x+8+(i*16),y+8,oEffect)
            tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
            tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
          }
          sprite_index=sNull
        }
      }
      else if phaseTime>=111 and phaseTime<=150
      {
        y+=8
        if y>=696
        {
          y=696
          phaseTime=0
          bossPhase+=1
        }
      }
    }
    else if bossPhase=6 //---------- MOVEMENT: Up to standard height ----------
    {
      if phaseTime>=10
      {
        y-=8
        if y<=544
        {
          y=544
          bFloorFlame=1
          phaseTime=0
          bossPhase+=1
        }
      }
    }
    else if bossPhase=7 //---------- MOVEMENT: To right side ----------
    {
      if phaseTime>=40
      {
        if laserMouthTime>=laserMouthDelay {laserMouthTime=laserMouthDelay-5}
        x+=8
        if x>=816
        {
          image_xscale=-1
          phaseTime=0
          bossPhase=1
        }
      }
    }

    if bossPhase!=4 and bossPhase!=5
    {
      //-------------------- ATTACK: MULTI EXPLODE MISSILE --------------------
      explodeMissileTime+=1
      if explodeMissileTime>=explodeMissileDelay and explodeMissileTime<=explodeMissileDelay+100 //Trigger attack
      {
        explodeMissileTime=10000
      }
      else if explodeMissileTime=10001
      {
        var tNewAttack,tDir;
        tDir=90-(explodeMissileNum*10)
        for(i=0;i<explodeMissileNum;i+=1)
        {
          tNewAttack=instance_create(x-(106*image_xscale),y-95,oCACA_ExpMissile)
          tNewAttack.atkPower=atkPower; tNewAttack.direction=tDir; tNewAttack.timeTillLaunch=15+(10*i)
          tDir+=10
        }
        explodeMissileTime=0
      }

      //-------------------- ATTACK: MOUTH LASER (Big) --------------------
      laserMouthTime+=1
      if laserMouthTime>=laserMouthDelay and laserMouthTime<=laserMouthDelay+100 //Trigger attack
      {
        laserMouthTime=10000
      }
      else if laserMouthTime=10005
      {
        var tNewAttack,tDir;
        if image_xscale=1 {tDir=10}
        else {tDir=170}
        for(i=0;i<3;i+=1)
        {
          tNewAttack=instance_create(x+(13*image_xscale),y-58,oCACA_MouthLaser)
          tNewAttack.atkPower=atkPower; tNewAttack.image_angle=tDir; tNewAttack.timeTillLaunch=15+(10*i)
          tNewAttack.idleTime=25
          tDir-=15*image_xscale
        }
        laserMouthTime=0
      }

      if bossProgress>=1 //-------------------- ATTACK: EYE LASER --------------------
      {
        laserEyeTime+=1
        if laserEyeTime>=laserEyeDelay and laserEyeTime<=laserEyeDelay+100 //Trigger attack
        {
          cirRad=45
          circleAlpha=1
          laserWarn=1
          laserEyeTime=10000
        }
        else if laserEyeTime>=10001 and laserEyeTime<=10020
        {
          cirRad-=2
          circleAlpha-=0.045
          if laserMouthTime=10015 {laserWarn=0}
        }
        else if laserEyeTime>=10031 and laserEyeTime<=10080
        {
          if laserEyeTime mod 3=0
          {
            playSound(global.snd_CShotA,0,0.94,35000)
            var tNewAttack;
            tNewAttack=instance_create(x+(13*image_xscale),y-90,oPassBullet)
            tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
            tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100
            tNewAttack.direction=point_direction(x+(13*image_xscale),y-90,oPlayer1.x,returnPlayerYCenter())
          }
        }
        else if laserEyeTime>=10081
        {
          laserEyeTime=0
        }
      }

      if bossProgress>=3 //-------------------- ATTACK: SKY LASER --------------------
      {
        skyLaserTime+=1
        if skyLaserTime>=skyLaserDelay and skyLaserTime<=skyLaserDelay+100
        {
          skyLaserTime=10000
        }
        else if skyLaserTime=10001
        {
          var newLaser;
          for(i=0;i<8;i+=1)
          {
            newLaser=instance_create((xCenter-roomSpan+16)+(96*i),yGround,oFNSkyLaser)
            newLaser.atkPower=atkPower; newLaser.idleTime=30; newLaser.onPlayer=1
            if i=0 {newLaser.bShake=1}
            else {newLaser.bShake=0}
          }
          skyLaserTime=0
        }
      }

      //-------------------- ATTACK: FLOOR FIRE SPREAD --------------------
      if bAtkFloorFire=1
      {
        atkFloorFireTime+=1
        if atkFloorFireTime>=atkFloorFireDelay and atkFloorFireTime<=atkFloorFireDelay+100
        {
          var tEffect,tScaling;
          tScaling=0.6+random(0.4)
          for(i=0;i<56;i+=1)
          {
            tEffect=instance_create(xCenter+random_range(-roomSpan,roomSpan),yGround,oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_alpha=0.7+random(0.2); tEffect.image_speed=0.35
            tEffect.image_xscale=tScaling; tEffect.image_yscale=tScaling
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-2-random(5)
          }
          atkFloorFireTime=10000
        }
        else if atkFloorFireTime=10030
        {
          playSound(global.snd_Flame1,0,1,12000)
          var tFloorFlame;
          tFloorFlame=instance_create(x,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=0
          tFloorFlame=instance_create(x+18,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=1
          tFloorFlame=instance_create(x-18,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=2
          atkFloorFireTime=0
        }
      }

      //-------------------- ATTACK: BACK EXPLODE MISSILE --------------------
      if (bossPhase=1 and oPlayer1.x>=x) or (bossPhase=3 and oPlayer1.x<=x)
      {
        backMissile+=1
        if backMissile>=12
        {
          playSound(global.snd_CShotB,0,0.92,1)
          var tNewAttack;
          tNewAttack=instance_create(x-(90*image_xscale),y-16,oPointExpBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
          tNewAttack.direction=point_direction(x-(90*image_xscale),y-16,oPlayer1.x,returnPlayerYCenter())
          backMissile=0
        }
      }
    }
    else if bossPhase=5 //----- CHEST LASER PHASE -----
    {
      chestLaserTime+=1
      if chestLaserTime>=9 and chestLaserTime<=54
      {
        playSound(global.snd_KirbySuck,0,0.95,8000)
        var tEffect,tDir;
        tDir=random_range(-35,35)
        tEffect=instance_create(x+lengthdir_x(64,tDir),y+lengthdir_y(64,tDir),oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=16; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=1.5; tEffect.image_yscale=1.5; tEffect.direction=tDir-180; tEffect.speed=4
        if bChestLight=0 {bChestLight=1}
        else {bChestLight=0}
      }
      else if chestLaserTime=68
      {
        bChestLight=1
        SS_StopSound(global.snd_KirbySuck)
        playSound(global.snd_CShotA,0,1,18000)
        playSound(global.snd_SpearShot,0,1,18000)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oCACA_ChestLaser)
        tNewAttack.atkPower=atkPower; tNewAttack.image_xscale=32
      }
      else if chestLaserTime>=70 and chestLaserTime<=110
      {
        if chestLaserTime mod 5=0
        {
          var tNewAttack;
          tNewAttack=instance_create(oPlayer1.x,yGround-208,oGravityBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.direction=270; tNewAttack.bulletSpeed=5; tNewAttack.damageType="EXPLOSION"
          tNewAttack.sprite_index=sC_TurretBombB
        }
      }
      else if chestLaserTime=120
      {
        if bossProgress>=3 {chestLaserTime=130}
      }
      else if chestLaserTime=150
      {
        if bombType=0
        {
          for(i=0;i<16;i+=1)
          {
            var tNewAttack;
            tNewAttack=instance_create(288+(bombSpacingA*i),yGround-208,oGravityBullet)
            tNewAttack.atkPower=atkPower; tNewAttack.direction=270; tNewAttack.bulletSpeed=5; tNewAttack.damageType="EXPLOSION"
            tNewAttack.sprite_index=sC_TurretBombA
          }
        }
        else if bombType=1
        {
          for(i=0;i<8;i+=1)
          {
            var tNewAttack;
            tNewAttack=instance_create(288+(bombSpacingB*i),yGround-208,oGravityBullet)
            tNewAttack.atkPower=atkPower; tNewAttack.direction=270; tNewAttack.bulletSpeed=5; tNewAttack.damageType="EXPLOSION"
            tNewAttack.sprite_index=sC_TurretBombB
          }
        }
      }
      else if chestLaserTime=160
      {
        if bossProgress>=3 {chestLaserTime=165}
      }
      else if chestLaserTime=175
      {
        if bombType=0 {bombType=1}
        else {bombType=0}
        bFloorFlame=0
        chestLaserTime=69
      }

      if hitsDuringLaser>=9 //Hit weak spot enough times with bombs
      {
        with oCACA_ChestLaser {instance_destroy()}
        with oDummyPlat
        {
          var tEffect;
          for(i=0;i<4;i+=1)
          {
            tEffect=instance_create(x+8+(i*16),y+8,oEffect)
            tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
            tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
          }
          sprite_index=sGWPlatform
        }
        hitsDuringLaser=0
        bChestLight=0
        chestLaserTime=0
        phaseTime=0
        bossPhase+=1
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      explodeMissileDelay-=10
      laserMouthDelay-=10
      bombSpacingA-=5
      bombSpacingB-=2
      bAtkFloorFire=1
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      explodeMissileDelay-=10
      explodeMissileNum+=1
      laserMouthDelay-=10
      laserEyeDelay-=9
      bombSpacingA-=5
      bombSpacingB-=2
      atkFloorFireDelay-=20
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
    {
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=0; tAtkShield.atkUp=1
      resType[0]=2
      explodeMissileDelay-=10
      laserMouthDelay-=10
      laserEyeDelay-=9
      bombSpacingA-=5
      bombSpacingB-=2
      atkFloorFireDelay-=20
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=3
    {
      explodeMissileDelay-=10
      explodeMissileNum+=1
      laserMouthDelay-=10
      laserEyeDelay-=9
      skyLaserDelay-=40
      bombSpacingA-=5
      bombSpacingB-=2
      atkFloorFireDelay-=20
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
    with oDummyPlat {sprite_index=sGWPlatform}
    with oEProjectileBase {instance_destroy()}
    msgCreate(0,0,"Jerry","Big ass robots don't stand a chaaaaaaaance!!",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
  }
  else if deathAnim>=2 and deathAnim<=79
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
  else if deathAnim>=80
  {
    if global.bBossGallery=1
    {
      bossRoomTally(51)
      global.newMapX=888; global.newMapY=496; room_goto(rBossGallery)
    }
    else
    {
      oEvCh18MainA.sceneProgress=1
      instance_destroy()
    }
  }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bFloorFlame=0
{
  if other.damageType="EXPLOSION"
  {
    hitsDuringLaser+=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sCACA_LeftLeg,0,x-(44*image_xscale),y+42,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sCACA_Body,0,x-(96*image_xscale),y+11,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if bChestLight=1
{
  draw_sprite_ext(sCACA_ChestLight,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
draw_sprite_ext(sCACA_RightLeg,0,x-(90*image_xscale),y+24,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sCACA_Arm,0,x-(88*image_xscale),y+24,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sCACA_Fingers,fingerFrm,x+(56*image_xscale),y+58,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if laserWarn>0
{
  draw_set_alpha(circleAlpha)
  draw_set_color(c_red)
  for(i=0;i<4;i+=1)
  {
    draw_circle(x+(13*image_xscale),y-90,cirRad*(i+1),1)
  }
}

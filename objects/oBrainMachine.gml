#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Brain Machine"
eLevel=33
maxLife=8300
life=maxLife
atkPower=9
resType[0]=2
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bossPhase=1
armsRotation=0
rotateSpd=2
xSpd=0
moveDir=1

shotTime=60
shotDelay=120
bulletNum=8

bArmLaser=0
armLaserTime=110
armLaserDelay=150
laserType=0
armMax=1
armNum=0

midLaserTime=150
midLaserDelay=350
midLaserDur=90

floorTrapTime=170
floorTrapDelay=330
floorTrapDuration=300

circleRad=0
barrierTime=0
barrierSet=0
//--------------------

//Misc Data
xCenter=288
yGround=288
roomSpan=224
yCenter=160

deathAnim=0

for(i=0;i<4;i+=1)
{
  myGrapplePoints[i]=instance_create(x,y,oStrikeChainPoint)
  armBlend[i]=c_white
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
    jeremyText="It only has three attacks. The first you'll notice is it will cause one of its joints extending out to burn red. Do not grapple onto its arms when it does that. Another is when you see a spark flash on it. It's going to fire a wave outward. The last is it will cause the floor to become electrified. You'll need to grapple onto its ends to avoid that. It also seems to modify its behavior as it goes on."
    chaoText="Sorry, I'm trying to hack into that computer, ask Jeremy what he's found out about this thing. This stuff is complicated so it may take a moment. Just keep that thing busy. There is one thing though. I was thinking about how the Strike Chain and your mobility work together. I bet it's really hard to get onto a grapple point after an air-dash, I bet grappling after a double jump is a lot easier."
    devText="The Strike Chain was fairly under-utilized up until this point I felt. There were always plans to have a boss encounter that takes advantage of it other than Sigma. There will probably be more. I really like how this encounter turned out."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bossPhase=1 //======================================== ATTACK PHASE 1 ========================================
    {
      event_user(1)
      //-------------------- ATTACK: Arm Laser --------------------
      armLaserTime+=1
      if armLaserTime>=armLaserDelay and armLaserTime<=armLaserDelay+100 //Glow chosen arms
      {
        for(i=0;i<armMax;i+=1)
        {
          armBlend[i]=c_red
        }
        armNum=armMax
        armLaserTime=10000
      }
      else if armLaserTime=10065
      {
        playSound(global.snd_CShotA,0,0.97,15000)
        for(i=0;i<armNum;i+=1)
        {
          myLaser[i]=instance_create(x,y,oBrMa_Laser)
          myLaser[i].atkPower=atkPower; myLaser[i].image_angle=(i*90)+armsRotation
        }
        bArmLaser=1
      }
      else if armLaserTime>=10215
      {
        for(i=0;i<4;i+=1)
        {
          armBlend[i]=c_white
        }
        with oBrMa_Laser {instance_destroy()}
        bArmLaser=0
        armLaserTime=0
      }

      if bArmLaser=1
      {
        for(i=0;i<armNum;i+=1)
        {
          myLaser[i].image_angle=(i*90)+armsRotation
        }
      }
      event_user(0)
    }
    else if bossPhase=2 //======================================== ATTACK PHASE 2 ========================================
    {
      event_user(1)
      //-------------------- ATTACK: Mid Laser --------------------
      midLaserTime+=1
      if midLaserTime>=midLaserDelay and shotTime<shotDelay-5
      {
        var tMidLaser;
        tMidLaser=instance_create(xCenter,0,oBrMa_MidLaser)
        tMidLaser.atkPower=atkPower; tMidLaser.idleTime=midLaserDur
        midLaserTime=0
      }

      //-------------------- ATTACK: Arm Laser (Permanent) --------------------
      armLaserTime+=1
      if armLaserTime=60 //Glow arms
      {
        armBlend[0]=c_red
        armBlend[2]=c_red
      }
      else if armLaserTime=125
      {
        playSound(global.snd_CShotA,0,1,11025)
        for(i=0;i<2;i+=1)
        {
          myLaser[i]=instance_create(x,y,oBrMa_Laser)
          myLaser[i].atkPower=atkPower; myLaser[i].image_angle=(i*180)+armsRotation
        }
        bArmLaser=1
      }

      if bArmLaser=1
      {
        for(i=0;i<2;i+=1)
        {
          myLaser[i].image_angle=(i*180)+armsRotation
        }
      }
      event_user(0)
    }
    else if bossPhase=3 //======================================== ATTACK PHASE 3 ========================================
    {
      //----- Movement -----
      if moveDir=1 //Right
      {
        x+=xSpd
        if xSpd<1 {xSpd+=0.04}
        if x>=xCenter+(roomSpan/2)-32 {moveDir=2}
      }
      else if moveDir=2 //Left
      {
        x+=xSpd
        if xSpd>-1 {xSpd-=0.04}
        if x<=xCenter-(roomSpan/2)+32 {moveDir=1}
      }

      //----- Barrier Switch -----
      if oGame.time mod 4=0
      {
        if circleRad=0 {circleRad=1}
        else {circleRad=0}
      }
      barrierTime+=1
      if barrierTime>=180
      {
        barrierSet+=1
        if barrierSet=3 {barrierSet=0}
        if barrierSet=0 //Shot
        {
          resType[2]=2
          resType[3]=3
          resType[5]=2
        }
        else if barrierSet=1 //Elemental
        {
          resType[2]=3
          resType[3]=2
          resType[5]=2
        }
        else if barrierSet=2 //Special
        {
          resType[2]=2
          resType[3]=2
          resType[5]=3
        }
        barrierTime=0
      }

      //-------------------- ATTACK: Circle Wave --------------------
      if !instance_exists(oBrMa_Laser)
      {
        event_user(1)
      }
      else
      {
        if shotTime>=shotDelay {shotTime=shotDelay-15}
      }

      //-------------------- ATTACK: Mid Laser --------------------
      midLaserTime+=1
      if midLaserTime>=midLaserDelay
      {
        var tMidLaser;
        tMidLaser=instance_create(xCenter,0,oBrMa_MidLaser)
        tMidLaser.atkPower=atkPower; tMidLaser.idleTime=midLaserDur
        midLaserTime=0
      }

      //-------------------- ATTACK: Arm Laser --------------------
      armLaserTime+=1
      if armLaserTime>=armLaserDelay and armLaserTime<=armLaserDelay+100 //Glow chosen arms
      {
        if laserType=0
        {
          armBlend[0]=c_red
          armBlend[2]=c_red
        }
        else if laserType=1
        {
          for(i=0;i<3;i+=1)
          {
            armBlend[i]=c_red
          }
        }
        armLaserTime=10000
      }
      else if armLaserTime=10075
      {
        playSound(global.snd_CShotA,0,0.97,15000)
        if laserType=0
        {
          for(i=0;i<2;i+=1)
          {
            myLaser[i]=instance_create(x,y,oBrMa_Laser)
            myLaser[i].atkPower=atkPower; myLaser[i].image_angle=(i*180)+armsRotation
          }
        }
        else if laserType=1
        {
          for(i=0;i<3;i+=1)
          {
            myLaser[i]=instance_create(x,y,oBrMa_Laser)
            myLaser[i].atkPower=atkPower; myLaser[i].image_angle=(i*90)+armsRotation
          }
        }
        bArmLaser=1
      }
      else if armLaserTime>=10225
      {
        for(i=0;i<4;i+=1)
        {
          armBlend[i]=c_white
        }
        with oBrMa_Laser {instance_destroy()}
        if laserType=0 {laserType=1}
        else {laserType=0}
        bArmLaser=0
        armLaserTime=0
      }

      if bArmLaser=1
      {
        if laserType=0
        {
          for(i=0;i<2;i+=1)
          {
            myLaser[i].image_angle=(i*180)+armsRotation
          }
        }
        else if laserType=1
        {
          for(i=0;i<3;i+=1)
          {
            myLaser[i].image_angle=(i*90)+armsRotation
          }
        }
      }
      event_user(0)
    }

    armsRotation+=rotateSpd
    for(i=0;i<4;i+=1)
    {
      myGrapplePoints[i].x=x+lengthdir_x(75,(i*90)+armsRotation)
      myGrapplePoints[i].y=y+lengthdir_y(75,(i*90)+armsRotation)
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0 //Phase 1
    {
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      resType[5]=2
      shotDelay-=5
      armLaserDelay-=10
      armMax+=1
      floorTrapDelay-=20
      floorTrapDuration+=20
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.46 and bossProgress=1 //Phase 2
    {
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
      resType[1]=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.1
      with oZapTrap {instance_destroy()}
      rotateSpd=-2
      shotTime=60
      shotDelay=230
      for(i=0;i<4;i+=1)
      {
        armBlend[i]=c_white
      }
      with oBrMa_Laser {instance_destroy()}
      bArmLaser=0
      armLaserTime=0
      floorTrapTime=160
      floorTrapDelay=330
      floorTrapDuration=220
      bossPhase=2
      bossProgress+=1
    }
    else if lifePercent<=0.45 and lifePercent>=0.31 and bossProgress=2 //Phase 2
    {
      shotDelay-=5
      midLaserDelay-=5
      midLaserDur+=10
      floorTrapDelay-=40
      floorTrapDuration+=20
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0.16 and bossProgress=3 //Phase 3
    {
      resType[2]=2
      resType[3]=3
      resType[5]=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.1
      with oZapTrap {instance_destroy()}
      with oBrMa_MidLaser {instance_destroy()}
      rotateSpd=3
      shotTime=60
      shotDelay=180
      for(i=0;i<4;i+=1)
      {
        armBlend[i]=c_white
      }
      with oBrMa_Laser {instance_destroy()}
      bArmLaser=0
      armLaserTime=40
      armLaserDelay=150
      midLaserTime=120
      midLaserDelay=340
      midLaserDur=85
      floorTrapTime=0
      floorTrapDelay=60
      floorTrapDuration=1000000
      bossPhase=3
      bossProgress+=1
    }
    else if lifePercent<=0.15 and lifePercent>=0 and bossProgress=4 //Phase 3
    {
      shotDelay-=5
      midLaserDelay-=10
      armLaserDelay-=10
      midLaserDur+=5
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
      bossRoomTally(49)
      global.newMapX=1176; global.newMapY=496; room_goto(rBossGallery)
    }
    else
    {
      with oZapTrap {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
      with oStrikeChainPoint {instance_destroy()}
      global.gamePaused=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.visible=0; oPlayer1.x=xCenter; oPlayer1.y=yGround

      mashingButtons=instance_create(0,0,oMashButtons)
      mashingButtons.xCenter=288; mashingButtons.yCenter=192
      mashingButtons.startJerryX=412; mashingButtons.startJerryY=224
      mashingButtons.startClaireX=164; mashingButtons.startClaireY=224
    }
  }
  else if deathAnim=15
  {
    msgCreate(0,0,"Claire","I've had enough of this!!",0,0,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if deathAnim=70
  {
    mashingButtons.bCanHit=1
  }
  else if deathAnim>=80 and deathAnim<=90
  {
    if deathAnim=85 {deathAnim=80}

    if mashingButtons.timeToStop<=0
    {
      global.gamePaused=false
      mashingButtons.bCanHit=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.visible=1
      deathAnim=150
    }
  }
  else if deathAnim>=151 and deathAnim<=210
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
  else if deathAnim>=211
  {
    oEvCh18MainA.sceneProgress=1
    instance_destroy()
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-------------------- ATTACK: Floor Trap --------------------
floorTrapTime+=1
if floorTrapTime>=floorTrapDelay and floorTrapTime<=floorTrapDelay+100
{
  for(i=0;i<7;i+=1)
  {
    myTrap=instance_create(64+(i*64),room_height+8,oZapTrap)
    myTrap.image_xscale=2
    floorTrapTime=1000
  }
}
else if floorTrapTime>=1001 and floorTrapTime<=1999
{
  oZapTrap.y-=1
  if oZapTrap.y<=282 {floorTrapTime=2000}
}
else if floorTrapTime>=2000+floorTrapDuration and bossPhase!=3
{
  oZapTrap.y+=4
  if oZapTrap.y>=room_height+8
  {
    with oZapTrap {instance_destroy()}
    floorTrapTime=0
  }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-------------------- ATTACK: Energy Wave Circle --------------------
shotTime+=1
if shotTime>=shotDelay and shotTime<=shotDelay+100 and midLaserTime<midLaserDelay-5
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
  tEffect.image_xscale=2.5; tEffect.image_yscale=2.5
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
  tEffect.image_xscale=2.5; tEffect.image_yscale=2.5; tEffect.image_angle=45
  shotTime=10000
}
else if shotTime=10045
{
  playSound(global.snd_LaserA,0,0.93,15000)
  if bossPhase=1
  {
    var tNewAttack,tDir;
    tDir=0
    for(i=0;i<bulletNum;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.9 tNewAttack.direction=tDir
      tDir+=360/bulletNum
    }
  }
  else
  {
    var tNewAttack,tDir;
    tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    tDir-=360/bulletNum
    for(i=0;i<3;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.9 tNewAttack.direction=tDir
      tDir+=360/bulletNum
    }
  }
  shotTime=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  draw_sprite_ext(sBM_Chain,0,x,y,image_xscale,image_yscale,(i*90)+armsRotation,armBlend[i],image_alpha)
}
event_inherited()

if bossPhase=3
{
  draw_set_alpha(1)
  if barrierSet=0 {draw_set_color(c_yellow)}
  else if barrierSet=1 {draw_set_color(c_green)}
  else if barrierSet=2 {draw_set_color(c_red)}
  draw_circle(x,y,32+circleRad,1)
}

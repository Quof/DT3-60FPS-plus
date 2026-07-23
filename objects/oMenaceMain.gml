#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: MAIN (BODY) -----
event_inherited()
bCanTakeDamage=false

//Enemy base statistics
eName="Menace"
maxLife=100
life=maxLife
atkPower=7
stunResist=50
affiliation=3
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0
//--------------------
//-- Leg Data --
stepDelay=30
stepTime=0
animProg=0
footPlacement=0 //0:Neutral, 1:Left Leg Forward
stepForward=0 //0:Forward, 1:Back
stepScale=1
currPos=8 //10

//-- Left Arm Data --
armScale=1
armAtkDelayL=250
armAtkTimeL=80
armAnimProgL=0
//-- Right Arm Data --
armAtkDelayR=190
armAtkTimeR=90
armAnimProgR=0
//-- Spinning Arm Data --
armSpinTime=45
armSpinDelay=970

//-- Head/Jaw Data --
headPoisonTime=170
headPoisonDelay=460
headLaserTime=250
headLaserDelay=840

//-- Other Attacks Data --
floorFire=0
firePillarTime=-1
firePillarDelay=620

//-- Spawn Data --
spawnTime=370
spawnDelay=480

//-- Misc Data --
yBodyMid=200
yGround=512
angleAdj=90

deathAnim=0

bHS=instance_create(x,y,oMenaceHitSpot)
bGroin=instance_create(x,y,oMenaceGroin)
bWings=instance_create(x,y,oMenaceWings)
bHead=instance_create(x,y,oMenaceHead)
bJaw=instance_create(x,y,oMenaceJaw)
bShoulderL=instance_create(x,y,oMenaceShoulder)
bShoulderL.side=0
bForearmL=instance_create(x,y,oMenaceForearm)
bForearmL.side=0
bHandL=instance_create(x,y,oMenaceHand)
bHandL.side=0
bLegL=instance_create(x,y,oMenaceLeg)
bLegL.side=0
bCalfL=instance_create(x,y,oMenaceCalf)
bCalfL.side=0
bFootL=instance_create(x,y,oMenaceFoot)
bFootL.side=0

bShoulderR=instance_create(x,y,oMenaceShoulder)
bShoulderR.side=1
bShoulderR.depth=38
bShoulderR.sprite_index=sMenaceBShoulder
bForearmR=instance_create(x,y,oMenaceForearm)
bForearmR.side=1
bForearmR.depth=37
bForearmR.sprite_index=sMenaceBForearm
bHandR=instance_create(x,y,oMenaceHand)
bHandR.side=1
bHandR.depth=36
bHandR.sprite_index=sMenaceBHand
bLegR=instance_create(x,y,oMenaceLeg)
bLegR.side=1
bLegR.depth=40
bLegR.sprite_index=sMenaceBLeg
bCalfR=instance_create(x,y,oMenaceCalf)
bCalfR.side=1
bCalfR.depth=41
bCalfR.sprite_index=sMenaceBCalf
bFootR=instance_create(x,y,oMenaceFoot)
bFootR.side=1
bFootR.depth=39
bFootR.sprite_index=sMenaceBFoot
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
    bActive=true
    jeremyText="Let's see, he's got two arm attacks... actually 3, a poison breath, a laser, can spawn minions... and there's some other stuff too... you'll see. These aren't all threatening on their own, but he can use almost all of them while waiting for other attacks to finish. He's got a lot of HP as well. Its weak spot is that thing on its chest, which is in a rather inconvenient spot."
    chaoText="This comes from the game 'Dawn of Sorrow' and was the rather long and somewhat boring final battle for the game. Something Jeremy didn't touch on was that you can deal 3x damage with NORMAL type attacks right when it starts charging a laser."
    devText="Menace replaced the Frankenstein boss fight I had planned, and it took way longer than that boss could ever hope to. It's fairly unusual for me to get multiple requests for the same thing, but Menace had quite a few. I have not actually played Dawn of Sorrow, but I looked at videos of Menace for quite awhile to figure out how it moved and decided I was able to do it. Plus I know it's going to be pretty cool to see this thing in DT."
    with oEnemyBase
    {
      jeremyText=oMenaceMain.jeremyText
      chaoText=oMenaceMain.chaoText
      devText=oMenaceMain.devText
      resType[0]=4
      resType[2]=4
    }
    oGlobalEvent.enemyCount=1
    bHS.bActive=true
    bHS.bShowHealthBar=true
    bHS.showBossHP=instance_create(0,0,oBossLifeDisplay)
    bHS.showBossHP.bossID=bHS.id
    bHS.showBossHP.type=0
    bHS.jeremyText=jeremyText; bHS.chaoText=chaoText; bHS.devText=devText
    activateBoss=2
  }

  if bActive=true and bHS.life>0
  {
    //-------------------- LEG MOVEMENT --------------------
    stepTime+=1
    if stepTime>=stepDelay
    {
      if stepTime=stepDelay //Setup
      {
        if random(10)<currPos-2 {stepForward=0}
        else {stepForward=1}

        if stepForward=0
        {
          if currPos mod 2=0 {footPlacement=0}
          else {footPlacement=1}
        }
        else if stepForward=1
        {
          if currPos mod 2=0 {footPlacement=1}
          else {footPlacement=0}
        }

        if armSpinTime>=1000 and currPos>0 //Go forward with arm flail
        {
          stepForward=0
          if currPos mod 2=0 {footPlacement=0}
          else {footPlacement=1}
        }

        if currPos=0 //Force back (Front wall)
        {
          stepForward=1
          footPlacement=1
        }
        else if currPos=10 //Force forward (Back wall)
        {
          stepForward=0
          footPlacement=0
        }
      }

      if footPlacement=0 {event_user(0)}
      else if footPlacement=1 {event_user(1)}
    }

    if armSpinTime<1000
    {
      //-------------------- LEFT ARM MOVEMENT --------------------
      armAtkTimeL+=1
      if armAtkTimeL=armAtkDelayL //Check distance to player
      {
        if point_distance(x,y,oPlayer1.x,oPlayer1.y)<208
          armAtkTimeL=armAtkDelayL+100
        else
          armAtkTimeL=armAtkDelayL-5
      }
      else if armAtkTimeL>=armAtkDelayL+100 //Swing arm
      {
        event_user(2)
      }

      //-------------------- RIGHT ARM MOVEMENT --------------------
      armAtkTimeR+=1
      if armAtkTimeR=armAtkDelayR //Check distance to player
      {
        if point_distance(x,y,oPlayer1.x,oPlayer1.y)<176
          armAtkTimeR=armAtkDelayR+100
        else
          armAtkTimeR=armAtkDelayR-5
      }
      else if armAtkTimeR>=armAtkDelayR+100 //Swing arm
      {
        event_user(3)
      }
    }

    //-------------------- SPINNING ARM ATTACK -------------------- 18 frames to make a full 360 swing
    armSpinTime+=1
    if armSpinTime>=armSpinDelay and armSpinTime<=999
    {
      if armAtkTimeL<armAtkDelayL and armAtkTimeR<armAtkDelayR //Check if arms are already in motion
      {
        armSpinTime=1000
      }
      else {armSpinTime=armSpinDelay-20}
    }
    else if armSpinTime=1001 //Afterimage
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_green
      tAfterI.image_alpha=0.75; tAfterI.image_xscale=image_xscale; tAfterI.depth=8; tAfterI.imageFade=0.05
      tAfterI.xScaling=0; tAfterI.yScaling=0.15; tAfterI.xShift=0.15; tAfterI.yShift=0; tAfterI.bFollow=-1
    }
    else if armSpinTime>=1031 and armSpinTime<=1210 //Flail arms
    {
      if stepTime<stepDelay
      {
        if bossProgress>=2 {stepScale=8}
        else {stepScale=4}
      }

      bShoulderL.bendAngle+=20; bShoulderR.bendAngle-=20
      bForearmL.bendAngle+=20; bForearmR.bendAngle-=20
    }
    else if armSpinTime>=1211 //End flail
    {
      if bossProgress>=2 {stepScale=2}
      else {stepScale=1}
      armSpinTime=0
    }

    //-------------------- HEAD POISON ATTACK --------------------
    headPoisonTime+=1
    if headPoisonTime>=headPoisonDelay
    {
      if headPoisonTime<=headPoisonDelay+100 //Check if laser is being used
      {
        if headLaserTime<headLaserDelay {headPoisonTime=10000}
        else {headPoisonTime=headPoisonDelay-20}
      }

      if headPoisonTime>=10001 and headPoisonTime<=10032 //Tilt head
      {
        var tPHeadAng;
        tPHeadAng=point_direction(bHead.x,bHead.y,oPlayer1.x,oPlayer1.y)
        if bHead.image_angle+235<tPHeadAng {bHead.bendAngle+=0.25}
        else {bHead.bendAngle-=0.25}
      }

      if headPoisonTime>=10001 and headPoisonTime<=10012 //Open jaw
        bJaw.bendAngle+=1
      else if headPoisonTime=10040 {playSound(global.snd_Beam,0,0.92,14000)} //Play breath sound
      else if headPoisonTime>=10041 and headPoisonTime<=10070 //Breath poison
      {
        var tPoison;
        tPoison=instance_create(bHead.x,bHead.y,oM_PoisonBreath)
        tPoison.atkPower=atkPower; tPoison.bulletSpeed=7+random(3)
        tPoison.animSpeed=0.25; tPoison.direction=(bHead.image_angle+235)+random_range(-12,12)
      }
      else if headPoisonTime>=10075 //Close jaw
      {
        if bJaw.bendAngle>0 {bJaw.bendAngle-=0.25}

        if bHead.bendAngle>0 {bHead.bendAngle-=0.25}
        else {bHead.bendAngle+=0.25}

        if bJaw.bendAngle=0 and bHead.bendAngle=0 {headPoisonTime=0}
      }
    }

    //-------------------- HEAD LASER ATTACK --------------------
    headLaserTime+=1
    if headLaserTime>=headLaserDelay
    {
      if headLaserTime<=headLaserDelay+100 //Check if poison is being used
      {
        if headPoisonTime<headPoisonDelay
        {
          playSound(global.snd_Charge,0,1,17000)
          with oEnemyBase {resType[0]=5}
          with oMenaceSpawn {resType[0]=3}
          headLaserTime=10000
        }
        else {headLaserTime=headLaserDelay-20}
      }

      if headLaserTime>=10001 and headLaserTime<=10026 //Tilt head
      {
        if headLaserTime=10001 {bHead.laserWarn=1}
        bHead.bendAngle-=3
      }

      if headLaserTime>=10001 and headLaserTime<=10008 //Open jaw
        bJaw.bendAngle+=1
      else if headLaserTime>=10041 and headLaserTime<=10066
      {
        if headLaserTime=10041
        {
          playSound(global.snd_LaserB,0,1,1)
          var tLaser;
          tLaser=instance_create(bHead.x,bHead.y,oM_LaserBreath)
          tLaser.atkPower=atkPower+1
        }
        bHead.bendAngle+=4
      }
      else if headLaserTime>=10070
      {
        if headLaserTime=10070
        {
          with oEnemyBase {resType[0]=4}
          with oMenaceSpawn {resType[0]=3}
          with oM_LaserBreath {instance_destroy()}
        }

        if bJaw.bendAngle>0 {bJaw.bendAngle-=0.5}
        bHead.bendAngle-=2
        if bHead.bendAngle=0 {headLaserTime=0}
      }
    }

    //-------------------- SPAWN MINION --------------------
    spawnTime+=1
    if spawnTime>=spawnDelay
    {
      instance_create(x,y,oMenaceSpawn)
      spawnTime=0
    }

    //-------------------- FLOOR FIRE --------------------
    if floorFire=1
    {
      instance_create(x,-64,oMenaceFireDrop)
      floorFire=2
    }

    //-------------------- FIRE PILLAR --------------------
    if firePillarTime>=0
    {
      firePillarTime+=1
      if firePillarTime>=firePillarDelay
      {
        if firePillarTime<=firePillarDelay+100 //Check updates
        {
          playSound(global.snd_FireCrackle,0,0.95,55000)
          firePillarTime=10000
          var tFFScl,tEffect;
          for(i=0;i<48;i+=1)
          {
            for(ii=0;ii<4;ii+=1)
            {
              tFFScl=random(0.15)
              tEffect=instance_create(256+(ii*128)+random(64),random_range(96,480),oEffectB)
              tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
              tEffect.image_alpha=0.6; tEffect.image_xscale=0.25+tFFScl; tEffect.image_yscale=0.25+tFFScl
              tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
              tEffect.fadeSpd=0.011; tEffect.image_blend=make_color_rgb(255,random(50),random(50))
              tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
            }
          }
        }
        else if firePillarTime>=10050
        {
          playSound(global.snd_Fireball,0,0.95,14500)
          for(i=0;i<4;i+=1)
          {
            instance_create(256+(i*128),96,oMenaceFirePillar)
          }
          firePillarTime=0
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if bHS.lifePercent<=0.85 and bHS.lifePercent>=0.69 and bossProgress=0
    {
      armAtkDelayL-=5
      armAtkDelayR-=5
      armSpinDelay-=15
      headPoisonDelay-=10
      headLaserDelay-=25
      spawnDelay-=25
      bossProgress+=1
    }
    else if bHS.lifePercent<=0.68 and bHS.lifePercent>=0.52 and bossProgress=1
    {
      armAtkDelayL-=5
      armAtkDelayR-=5
      armSpinDelay-=15
      headPoisonDelay-=10
      headLaserDelay-=25
      spawnDelay-=25
      firePillarTime=300
      bossProgress+=1
    }
    else if bHS.lifePercent<=0.51 and bHS.lifePercent>=0.36 and bossProgress=2
    {
      var tAtkShield;
      tAtkShield=instance_create(bHS.x,bHS.y,oAtkTypeShield); tAtkShield.ownerID=bHS.id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=2; tAtkShield.atkUp=1
      with oEnemyBase {resType[2]=3}
      with oMenaceSpawn {resType[2]=4}
      armAtkDelayL-=5
      armAtkDelayR-=5
      armSpinDelay-=15
      headPoisonDelay-=10
      headLaserDelay-=25
      spawnDelay-=25
      firePillarDelay-=25
      floorFire=1
      bossProgress+=1
    }
    else if bHS.lifePercent<=0.35 and bHS.lifePercent>=0 and bossProgress=3
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=bHS.id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
      with oEnemyBase {resType[1]=2}
      with oMenaceSpawn {resType[1]=3}
      armAtkDelayL-=5
      armAtkDelayR-=5
      armSpinDelay-=15
      headPoisonDelay-=20
      headLaserDelay-=100
      spawnDelay-=25
      firePillarDelay-=25
      bossProgress+=1
    }
  }
  else if bHS.life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      bHS.visible=false
      with oTrapBase {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oMenaceSpawn {instance_destroy()}
      with oEnemyBase
      {
        bCanDealDamage=false
        deathFlail=1
        xVel=random_range(-4,4)
        yVel=-4-random(8)
        spinSpd=choose(-30,-15,15,30)
      }
    }
    else if deathAnim>=2 and deathAnim<=120
    {
      with oEnemyBase
      {
        yVel+=0.4
        image_angle+=spinSpd
      }
    }
    else if deathAnim>=121
    {
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.4
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tDir=0
      for(i=0;i<40;i+=1)
      {
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
        tEffect.speed=6; tEffect.direction=tDir
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tDir+=360/40
      }
      if global.bBossGallery=1
      {
        bossRoomTally(12)
        global.newMapX=2568; global.newMapY=1312; room_goto(rBossGallery)
      }
      else
      {
        with oEnemyBase {instance_destroy()}
      }
    }
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ANIMATION: LEFT LEG (FRONT) --
animProg+=1*stepScale
if animProg>=1 and animProg<=40 //Rotate leg to lift foot up
{
  if stepForward=0 //Forward
  {
    bLegL.x-=1*stepScale
    x-=0.5*stepScale
  }
  else if stepForward=1 //Back
  {
    bLegL.x+=1*stepScale
    x+=0.5*stepScale
  }
  bLegL.bendAngle-=1*stepScale
  bLegL.y-=0.25*stepScale
  y-=0.25*stepScale
}
else if animProg>=41 and animProg<=80 //Rotate leg to bring foot back down
{
  if stepForward=0 //Forward
  {
    bLegL.x-=1*stepScale
    x-=0.5*stepScale
  }
  else if stepForward=1 //Back
  {
    bLegL.x+=1*stepScale
    x+=0.5*stepScale
  }
  bLegL.bendAngle+=1*stepScale
  bLegL.y+=0.25*stepScale
  y+=0.25*stepScale
  if animProg=80 //End
  {
    playSound(global.snd_HardHit1,0,1,7000)
    for(i=0;i<13;i+=1)
    {
      var tEffect,tEfSize;
      tEfSize=1+random(1)
      tEffect=instance_create((bFootL.x-82)+(i*9),yGround,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.3+random(0.45)
      tEffect.image_xscale=tEfSize; tEffect.image_yscale=tEfSize
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    stepTime=irandom(29)
    animProg=0
    footPlacement=1
    if stepForward=0 currPos-=1
    else currPos+=1
  }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ANIMATION: RIGHT LEG (BACK) --
animProg+=1*stepScale
if animProg>=1 and animProg<=40 //Rotate leg to lift foot up
{
  if stepForward=0 //Forward
  {
    bLegR.x-=1*stepScale
    x-=0.5*stepScale
  }
  else if stepForward=1 //Back
  {
    bLegR.x+=1*stepScale
    x+=0.5*stepScale
  }
  bLegR.bendAngle-=1*stepScale
  bLegR.y-=0.25*stepScale
  y-=0.25*stepScale
}
else if animProg>=41 and animProg<=80 //Rotate leg to bring foot back down
{
  if stepForward=0 //Forward
  {
    bLegR.x-=1*stepScale
    x-=0.5*stepScale
  }
  else if stepForward=1 //Back
  {
    bLegR.x+=1*stepScale
    x+=0.5*stepScale
  }
  bLegR.bendAngle+=1*stepScale
  bLegR.y+=0.25*stepScale
  y+=0.25*stepScale
  if animProg=80 //End
  {
    playSound(global.snd_HardHit1,0,1,5000)
    for(i=0;i<13;i+=1)
    {
      var tEffect,tEfSize;
      tEfSize=1+random(1)
      tEffect=instance_create((bFootR.x-82)+(i*9),yGround,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.3+random(0.45)
      tEffect.image_xscale=tEfSize; tEffect.image_yscale=tEfSize
      tEffect.image_blend=c_ltgray; tEffect.depth=38
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    stepTime=irandom(29)
    stepTime=0
    animProg=0
    footPlacement=0
    if stepForward=0 currPos-=1
    else currPos+=1
  }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ANIMATION: LEFT ARM (FRONT) --
armAnimProgL+=1*armScale
if armAnimProgL>=1 and armAnimProgL<=40
{
  bShoulderL.bendAngle+=1*armScale
  bForearmL.bendAngle-=0.25*armScale
}
else if armAnimProgL>=61 and armAnimProgL<=76
{
  if armAnimProgL=61 {playSound(global.snd_PlayerAtk[1],0,1,5512)}
  bShoulderL.bendAngle-=8*armScale
  bForearmL.bendAngle-=1*armScale
}
else if armAnimProgL>=84 and armAnimProgL<=96 //End
{
  bShoulderL.bendAngle+=7.3*armScale
  bForearmL.bendAngle+=2.1*armScale
  if armAnimProgL=96
  {
    bShoulderL.bendAngle=0
    bForearmL.bendAngle=0
    armAnimProgL=0
    armAtkTimeL=0
  }
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ANIMATION: RIGHT ARM (BACK) --
armAnimProgR+=1*armScale
if armAnimProgR>=1 and armAnimProgR<=32
{
  bShoulderR.bendAngle+=1*armScale
  bForearmR.bendAngle-=0.25*armScale
}
else if armAnimProgR>=60 and armAnimProgR<=68
{
  if armAnimProgR=60 {playSound(global.snd_PlayerAtk[0],0,1,5512)}
  bShoulderR.bendAngle-=8*armScale
  bForearmR.bendAngle-=1*armScale
}
else if armAnimProgR>=80 and armAnimProgR<=92 //End
{
  bShoulderR.bendAngle+=2.6*armScale
  bForearmR.bendAngle+=1.3*armScale
  if armAnimProgR=92
  {
    bShoulderR.bendAngle=0
    bForearmR.bendAngle=0
    armAnimProgR=0
    armAtkTimeR=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
/*
draw_set_color(c_black)
draw_set_alpha(1)
draw_set_halign(fa_left)
draw_set_font(fnt_StatRender)
textDropShadow(string("x: ") +string(x),view_xview[0]+300,view_yview[0]+10,c_white,c_black,1)
textDropShadow(string("y: ") +string(y),view_xview[0]+300,view_yview[0]+20,c_white,c_black,1)
textDropShadow(string("Position: ") +string(currPos),view_xview[0]+300,view_yview[0]+30,c_white,c_black,1)
textDropShadow(string("armSpinTime: ") +string(armSpinTime),view_xview[0]+300,view_yview[0]+40,c_white,c_black,1)
textDropShadow(string("headPoisonTime: ") +string(headPoisonTime),view_xview[0]+300,view_yview[0]+50,c_white,c_black,1)
textDropShadow(string("headLaserTime: ") +string(headLaserTime),view_xview[0]+300,view_yview[0]+60,c_white,c_black,1)

#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
//Enemy base statistics
eName="Blackmore"
eLevel=13
maxLife=8600
life=maxLife
atkPower=6
resType[0]=4
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

//Movement Data
bErratic=1
bendSpd=0
bendProg=0
moveDir=0

moveCycle=0
moveTime=0
warnCircle=0

flameProg=0
flameMove=0

posCheck=0

advancingWall=0

//Arm Data
armScale=1
dArmSwingTime=140
dArmSwingDelay=180
dArmSwingProg=0
armMeteorTime=120
armMeteorDelay=240
armMeteorProg=0
meteorAmt=3
fallMeteorTime=100
fallMeteorDelay=400

//Super Attack Data
despProg=0
despTime=0
despY1=160
despY2=208
despY3=256

//Misc Data
xCenter=544
yGround=304
roomSpan=192
angleAdj=90
bodyMove=pi/2
for(i=0;i<2;i+=1) {fingerMove[i]=pi/2}

deathAnim=0

jeremyText="The main thing you gotta watch out for is his shadow. If you duck, you can't be hit by either him or his shadow, well as long as you aren't too close."
chaoText="It can be hard to read his movements since he's so erratic with them. As the fight moves on, that flame will move to the right, which will cause his shadows to project more toward you. You're gonna need to watch the wave pattern in his arms to see when he has an opening for you to jump and hit. It probably isn't a good idea to wait till your energy recharges for the Holy Water unless you're really good at dodging those meteors."
devText="This was a tricky encounter to make. I wanted to make Blackmore himself less threatening than the shadow, but making sure the shadow didn't go bazonkers proved pretty hard with all those moving parts due to how I had shadow casting work in this. I wound up keeping it heavily scripted to prevent that."

bShoulderL=instance_create(x,y,oBlackmoorShoulder)
bShoulderL.side=0
bForearmL=instance_create(x,y,oBlackmoorForearm)
bForearmL.side=0
bHandL=instance_create(x,y,oBlackmoorHand)
bHandL.side=0
for(i=0;i<4;i+=1)
{
  bFingerL[i]=instance_create(x,y,oBlackmoorFingers)
  bFingerL[i].side=0
  bFingerL[i].type=i
}

bShoulderR=instance_create(x,y,oBlackmoorShoulder)
bShoulderR.side=1
bForearmR=instance_create(x,y,oBlackmoorForearm)
bForearmR.side=1
bHandR=instance_create(x,y,oBlackmoorHand)
bHandR.side=1
for(i=0;i<4;i+=1)
{
  bFingerR[i]=instance_create(x,y,oBlackmoorFingers)
  bFingerR[i].side=1
  bFingerR[i].type=i
}

for(i=0;i<24;i+=1)
{
  instance_create((xCenter-roomSpan+8)+(i*16),yGround,oBlackmoorFlame)
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

    for(i=0;i<80;i+=1)
    {
      var tEffect;
      tEffect=instance_create(x-random(105),y-random(105),oEffect)
      tEffect.sprite_index=sDeathFlameA
      tEffect.image_speed=0.2+random(0.2)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    with oEnemyBase
    {
      atkPower=6
      jeremyText=oBlackmoorMain.jeremyText
      chaoText=oBlackmoorMain.chaoText
      devText=oBlackmoorMain.devText
      var myShadow;
      myShadow=instance_create(0,0,oObjectShadow)
      myShadow.ownerID=id; myShadow.type=3; myShadow.maxShadowDist=192
    }
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //Erratic movement
    if bErratic=1
    {
      if bendProg=0
      {
        bendSpd-=0.05
        if bendSpd<=-0.5 {bendProg=1}
      }
      else if bendProg=1
      {
        bendSpd+=0.05
        if bendSpd>=0.5 {bendProg=0}
      }
      image_angle+=bendSpd
      bodyMove+=1
    }
    for(i=0;i<2;i+=1) {fingerMove[i]+=0.8+(i*0.2)}

    if despProg<=1
    {
      //-------------------- NORMAL MOVEMENT PATTERN --------------------
      moveTime+=1
      if moveCycle=0 //Stationary, then V-shape
      {
        if moveTime>=241 and moveTime<=300 {y-=0.25}
        else if moveTime>=301 and moveTime<=330 {x+=0.25; y+=0.25}
        else if moveTime>=331 and moveTime<=360
        {
          x-=0.25; y+=0.25
          if moveTime=360 {moveTime=0; moveCycle+=1}
        }
      }
      else if moveCycle=1 //Go to back of room, then back to mid
      {
        if moveTime=210 or moveTime=270 or moveTime=330 {instance_create(x,despY1,oBlackmoorSword)}

        if moveTime>=201 and moveTime<=220
        {
          if moveTime=201
          {
            playSound(global.snd_ChargeStrike,0,0.92,19000)
            var tEffect;
            tEffect=instance_create(x-48,y-32,oEffect)
            tEffect.sprite_index=sGroundBlast; tEffect.image_angle=90; tEffect.image_blend=c_black; tEffect.image_speed=0.5
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          x+=4
        }
        else if moveTime=401 {warnCircle=80}
        else if moveTime>=431 and moveTime<=450
        {
          if moveTime=431
          {
            playSound(global.snd_ChargeStrike,0,0.92,19000)
            var tEffect;
            tEffect=instance_create(x,y-32,oEffect)
            tEffect.sprite_index=sGroundBlast; tEffect.image_angle=270; tEffect.image_blend=c_black; tEffect.image_speed=0.5
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          x-=4
          if moveTime=450 {moveTime=0; moveCycle+=1}
        }
      }
      else if moveCycle=2 //Circle in place
      {
        if moveTime>=201
        {
          speed=0.25
          direction=moveDir
          moveDir+=2
          if moveDir=180 {speed=0; moveDir=0; moveTime=0; moveCycle=0}
        }
      }

      //-------------------- ATTACK: DOUBLE ARM SWING --------------------
      dArmSwingTime+=1
      if dArmSwingTime>=dArmSwingDelay and dArmSwingTime<=dArmSwingDelay+100 //Check distance to player
      {
        if point_distance(x,y,oPlayer1.x,oPlayer1.y)<208 and armMeteorTime<armMeteorDelay {dArmSwingTime=10000}
        else {dArmSwingTime=dArmSwingDelay-10}
      }
      else if dArmSwingTime>=10000
      {
        event_user(0)
      }

      //-------------------- ATTACK: METEOR SUMMON (With arms) --------------------
      armMeteorTime+=1
      if armMeteorTime>=armMeteorDelay and armMeteorTime<=armMeteorDelay+100
      {
        if dArmSwingTime<dArmSwingDelay-45 {armMeteorTime=10000}
        else {armMeteorTime=armMeteorDelay-55}
      }
      else if armMeteorTime>=10000
      {
        event_user(1)
      }

      //-------------------- ATTACK: METEOR SUMMON FALL --------------------
      fallMeteorTime+=1
      if fallMeteorTime>=fallMeteorDelay and fallMeteorTime<=fallMeteorDelay+100
      {
        if armMeteorTime<armMeteorDelay-20 {fallMeteorTime=10000}
        else {fallMeteorTime=fallMeteorDelay-30}
      }
      else if fallMeteorTime=10001
      {
        var newMeteor;
        for(i=0;i<7;i+=1)
        {
          newMeteor=instance_create((xCenter-roomSpan)+(i*72),-24-(i*48),oBlackmoorMeteor)
          newMeteor.atkPower=atkPower; newMeteor.bulletSpeed=8+(i/10); newMeteor.direction=270
        }
      }
      else if fallMeteorTime=10061
      {
        var newMeteor;
        for(i=0;i<7;i+=1)
        {
          newMeteor=instance_create((xCenter+roomSpan)-(i*72),-24-(i*48),oBlackmoorMeteor)
          newMeteor.atkPower=atkPower; newMeteor.bulletSpeed=8+(i/10); newMeteor.direction=270
        }
      }
      else if fallMeteorTime=10080 {fallMeteorTime=0}
    }

    if posCheck=0 and y<216 {posCheck=32}
    if posCheck>0
    {
      y+=1
      posCheck-=1
    }

    //Desperation Attack
    if despProg>=1 {event_user(2)}

    //-------------------- UTILITY: FLAME MOVE --------------------
    if flameProg=1
    {
      oGateCFlame.x+=0.25
      flameMove+=1
      if flameMove=32 {flameMove=0; flameProg=0}
    }

    //-------------------- UTILITY: ADVANCING WALL --------------------
    if advancingWall>=1 and advancingWall<9000
    {
      advancingWall+=1
      if advancingWall=2 {instance_create(256,112,oBlackmoorDeathWall)}
      oBlackmoorDeathWall.x+=1
      if oBlackmoorDeathWall.x>=352 {advancingWall=10000}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.88 and lifePercent>=0.76 and bossProgress=0
    {
      dArmSwingDelay-=5
      fallMeteorDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.75 and lifePercent>=0.63 and bossProgress=1
    {
      flameProg=1
      meteorAmt+=1
      dArmSwingDelay-=5
      bossProgress+=1
    }
    else if lifePercent<=0.62 and lifePercent>=0.51 and bossProgress=2
    {
      armMeteorDelay-=10
      fallMeteorDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.50 and lifePercent>=0.38 and bossProgress=3
    {
      dArmSwingDelay-=5
      fallMeteorDelay-=10
      advancingWall=1
      bossProgress+=1
    }
    else if lifePercent<=0.37 and lifePercent>=0.26 and bossProgress=4
    {
      flameProg=1
      meteorAmt+=1
      armMeteorDelay-=10
      //despProg=1
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0.13 and bossProgress=5
    {
      dArmSwingDelay-=5
      fallMeteorDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.12 and lifePercent>=0 and bossProgress=6
    {
      meteorAmt+=1
      armMeteorDelay-=10
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      speed=0
      with oObjectShadow {instance_destroy()}
      with oBlackmoorMeteor {instance_destroy()}
      with oBlackmoorShadowExp {instance_destroy()}
      with oBlackmoorFlame {instance_destroy()}
      with oBlackmoorDeathWall {instance_destroy()}
      with oBlackmoorSword {instance_destroy()}
      with oEnemyBase {bCanDealDamage=false}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(15)
        global.newMapX=2904; global.newMapY=1024; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        with oEnemyBase {instance_destroy()}
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATTACK: DOUBLE ARM SWING --
dArmSwingProg+=1
if dArmSwingProg>=1 and dArmSwingProg<=30
{
  image_angle-=1
  bShoulderL.atkAngle+=0.5
  bForearmL.atkAngle-=0.5
}
else if dArmSwingProg>=41 and dArmSwingProg<=60 //Left arm swing
{
  image_angle+=2
  bShoulderL.atkAngle-=4
}
else if dArmSwingProg>=71 and dArmSwingProg<=90 //Right arm swing
{
  image_angle-=0.5
  bShoulderL.atkAngle+=2
  bForearmL.atkAngle+=0.5
  bShoulderR.atkAngle-=4
  bForearmR.atkAngle-=2
}
else if dArmSwingProg>=91 and dArmSwingProg<=110
{
  bShoulderL.atkAngle+=1.25
  bForearmL.atkAngle+=0.25
  bShoulderR.atkAngle+=4
  bForearmR.atkAngle+=2
  if dArmSwingProg=110
  {
    dArmSwingProg=0
    dArmSwingTime=0
  }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-- ATTACK: METEOR SUMMON (With arms) --
armMeteorProg+=1
if armMeteorProg>=1 and armMeteorProg<=30
{
  if armMeteorProg=1 {playSound(global.snd_DemonLaugh,0,0.92,12000)}
  image_angle-=0.5
  bShoulderL.atkAngle-=1
  bForearmL.atkAngle-=0.25
  bShoulderR.atkAngle+=1
  bForearmR.atkAngle+=0.25
}
else if armMeteorProg>=51 and armMeteorProg<=70
{
  image_angle+=1
  bShoulderL.atkAngle+=2
  bForearmL.atkAngle+=0.5
  bShoulderR.atkAngle-=2
  bForearmR.atkAngle-=0.5
  if armMeteorProg=51
  {
    var newMeteor;
    for(i=0;i<meteorAmt;i+=1)
    {
      newMeteor=instance_create(x-(i*40),-24,oBlackmoorMeteor)
      newMeteor.atkPower=atkPower
      newMeteor.bulletSpeed=6+(i/2)-(meteorAmt/3)
      newMeteor.direction=260-((i*6))
    }
  }
}
else if armMeteorProg>=71 and armMeteorProg<=80
{
  image_angle-=0.5
  bShoulderL.atkAngle-=1
  bForearmL.atkAngle-=0.25
  bShoulderR.atkAngle+=1
  bForearmR.atkAngle+=0.25
  if armMeteorProg=80
  {
    armMeteorProg=0
    armMeteorTime=0
  }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Desperation Attack
if despProg=1 //Be sure arm attacks are not in progress
{
  if dArmSwingTime<dArmSwingDelay and armMeteorTime<armMeteorDelay
  {
    dArmSwingTime=dArmSwingDelay-30
    armMeteorTime=armMeteorDelay-90
    moveCycle=0; moveTime=0
    bCanTakeDamage=0
    despProg+=1
  }
}
else if despProg=2 //Back away to the right and dim room lights
{
  if oEvExGates.fadeAlpha<0.2 {oEvExGates.fadeAlpha+=0.005; image_alpha-=0.005}
  if x<688 {x+=2}
  if x>=688 and oEvExGates.fadeAlpha>=0.2 {despProg+=1}
}
else if despProg=3 //Attack
{
  despTime+=1
  if despTime=10 {instance_create(x,despY1,oBlackmoorSword)} //Set 1
  else if despTime=25 {instance_create(x,despY2,oBlackmoorSword)}
  else if despTime=40 {instance_create(x,despY3,oBlackmoorSword)}
  else if despTime=100 {instance_create(x,despY1,oBlackmoorSword)} //Set 2
  else if despTime=105 {instance_create(x,despY3,oBlackmoorSword)}
  else if despTime=130 {instance_create(x,despY2,oBlackmoorSword)}
  else if despTime=170 {instance_create(x,despY3,oBlackmoorSword)} //Set 3
  else if despTime=180 {instance_create(x,despY2,oBlackmoorSword)}
  else if despTime=190 {instance_create(x,despY1,oBlackmoorSword)}
  else if despTime>=260 and despTime<=280 //Set 4
  {
    if despTime mod 5=0
    {
      instance_create(x,despY1,oBlackmoorSword)
      instance_create(x,despY3,oBlackmoorSword)
    }
  }
  else if despTime>=300 {despTime=0; despProg+=1}

  if despTime mod 45=0 //Meteors
  {
    var newMeteor;
    newMeteor=instance_create(oPlayer1.x,-24,oBlackmoorMeteor)
    newMeteor.atkPower=atkPower; newMeteor.bulletSpeed=8+(i/10); newMeteor.direction=270
  }
}
else if despProg=4 //End
{
  despTime+=1
  if despTime>=45
  {
    if oEvExGates.fadeAlpha>0 {oEvExGates.fadeAlpha-=0.005; image_alpha+=0.005}
    speed=2
    direction=point_direction(x,y,576,256)

    if point_distance(x,y,576,256)<4 and oEvExGates.fadeAlpha=0
    {
      bCanTakeDamage=1
      speed=0
      x=576; y=256
      despProg=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if warnCircle>0
{
  warnCircle-=4
  draw_set_color(c_black)
  draw_set_alpha(0.2)
  draw_circle(x-32,y-32,warnCircle,0)
  draw_set_alpha(1)
  draw_circle(x-32,y-32,warnCircle,1)
}

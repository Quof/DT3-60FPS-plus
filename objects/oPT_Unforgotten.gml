#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCenterDamageNotice=1
image_xscale=-1
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="Lv.?? The Unforgotten"
eLevel=29
maxLife=21000
life=maxLife
atkPower=8
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=6
dieEffect=0
bossProgress=0
activateBoss=0

bCanBeBlocked=1
bParryOpp=0
blockCost=100

waitTime=30
moveCycle=1
moveTime=100
moveSpd=2
attackCycle=1
attackTime=0
flythrough=0
bulletStorm=0
spawnAmt=0
maxSpawn=2

colR=255; colG=255; colB=255

//--------------------

//Misc Data
xCenter=368
yGround=208
roomSpan=196

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
    jeremyText="Putting all meta-jokes aside, this guy can be pretty tough. He cycles through 5 different movement sets. During each, he will cycle between 1 of 3 different attacks. During his escape out of each movement set, he will begin to shake. Move out of the way when he does that. You can't parry when he flies through the arena. Do note that when he glows red, Claire can parry that attack."
    chaoText="This thing is from a Sega Genesis game called 'Beyond Oasis', and known as 'Story of Thor' in Japan."
    devText="This has been a highly requested enemy ever since there was a screenshot of it in DT1. It was originally planned to be a boss fight upon immediate arrival in the first Distortion level, but was cut very early on. I didn't want a boss fight immediately after Meta Knight and I couldn't come up with anything very interesting for it."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    waitTime+=1
    if waitTime>=5 and flythrough<=1
    {
      event_user(0) //Movement cycles
      event_user(1) //Attack cycles
    }
    else if flythrough>=2 //Fly through arena
    {
      flythrough+=1
      if flythrough>=6 and flythrough<=30
      {
        if flythrough mod 2=0 {y+=2} else {y-=2}
      }
      else if flythrough>=31 and flythrough<=200
      {
        if moveCycle=1 {x-=12}
        else if moveCycle=2 {x+=12; y-=9.6}
        else if moveCycle=3 {x-=12; y-=9.6}
        else if moveCycle=4 {x+=12}
        else if moveCycle=5 {y+=12}
        if x<=-312 or x>=room_width+312 or y<=-312 or y>=room_height+312 {flythrough=200}
      }
      else if flythrough>=205
      {
        moveTime=0
        image_angle=0
        moveCycle+=1
        if moveCycle=6 {moveCycle=1}
        flythrough=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
    {
      moveSpd+=2
      maxSpawn+=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.26 and bossProgress=1
    {
      maxSpawn+=1
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=2
    {
      moveSpd+=2
      bossProgress+=1
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      with oPT_ForgottenSpawn {instance_destroy()}
    }

    if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
    tEffect=instance_create(x+random_range(-300,100),y+random_range(-72,72),oEffect)
    tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
    tEffect.image_alpha=0.5+(image_alpha/3)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    image_alpha-=0.02
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(44)
        global.newMapX=2152; global.newMapY=528; room_goto(rBossGallery)
      }
      else
      {
        oEvCh15MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if attackCycle=1 and global.stJGame_C[0]>4000
{
  resType[0]=5
  event_inherited()
  resType[0]=3
}
else {event_inherited()}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moveTime+=1
if moveCycle=1 //-------------------- Upper right --------------------
{
  if moveTime=1
  {
    x=736; y=130
    image_xscale=-1
  }
  else if moveTime>=2 and moveTime<=99
  {
    x-=moveSpd
    if x<=560 {moveTime=100}
  }
  else if moveTime=110 {attackTime=1}
  else if moveTime>=1011
  {
    x+=moveSpd
    if x>=736
    {
      moveCycle=2
      waitTime=0
      moveTime=0
    }
  }
}
else if moveCycle=2 //-------------------- Lower left --------------------
{
  if moveTime=1
  {
    x=0; y=336
    image_xscale=1
    image_angle=30
  }
  else if moveTime>=2 and moveTime<=99
  {
    x+=moveSpd; y-=moveSpd*0.8
    if x>=176 {moveTime=100}
  }
  else if moveTime=110 {attackTime=1}
  else if moveTime>=1011
  {
    x-=moveSpd; y+=moveSpd*0.8
    if x<=0
    {
      image_angle=0
      moveCycle=3
      waitTime=0
      moveTime=0
    }
  }
}
else if moveCycle=3 //-------------------- Lower right --------------------
{
  if moveTime=1
  {
    x=736; y=336
    image_xscale=-1
    image_angle=330
  }
  else if moveTime>=2 and moveTime<=99
  {
    x-=moveSpd; y-=moveSpd*0.8
    if x<=560 {moveTime=100}
  }
  else if moveTime=110 {attackTime=1}
  else if moveTime>=1011
  {
    x+=moveSpd; y+=moveSpd*0.8
    if x>=736
    {
      image_angle=0
      moveCycle=4
      waitTime=0
      moveTime=0
    }
  }
}
else if moveCycle=4 //-------------------- Upper left --------------------
{
  if moveTime=1
  {
    x=0; y=130
    image_xscale=1
  }
  else if moveTime>=2 and moveTime<=99
  {
    x+=moveSpd
    if x>=176 {moveTime=100}
  }
  else if moveTime=110 {attackTime=1}
  else if moveTime>=1011
  {
    x-=moveSpd
    if x<=0
    {
      moveCycle=5
      waitTime=0
      moveTime=0
    }
  }
}
else if moveCycle=5 //-------------------- Top --------------------
{
  if moveTime=1
  {
    x=368; y=-128
    image_xscale=1
    image_angle=270
  }
  else if moveTime>=2 and moveTime<=99
  {
    y+=moveSpd
    if y>=20 {moveTime=100}
  }
  else if moveTime>=105 and moveTime<=145
  {
    if x+8<oPlayer1.x {x+=moveSpd}
    else if x-8>oPlayer1.x {x-=moveSpd}
  }
  else if moveTime=155 {attackTime=1}
  else if moveTime>=1011
  {
    y-=moveSpd
    if y<=-128
    {
      image_angle=0
      moveCycle=1
      waitTime=0
      moveTime=0
    }
  }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if attackTime>0{attackTime+=1}
if attackCycle=1 //-------------------- [RED] Lunge Attack --------------------
{
  if attackTime>=1 and attackTime<=10
  {
    colG-=15; colB-=15
    baseColor=make_color_rgb(colR,colG,colB)
    image_blend=baseColor
  }
  else if attackTime>=31 and attackTime<=40 //Lunge forward
  {
    if attackTime=31
    {
      playSound(global.snd_ChargeStrike,0,0.95,15000)
      bParryOpp=1
    }
    else if attackTime=40 {bParryOpp=0}

    if moveCycle=1 {x-=12}
    else if moveCycle=2 {x+=12; y-=9.6}
    else if moveCycle=3 {x-=12; y-=9.6}
    else if moveCycle=4 {x+=12}
    else if moveCycle=5 {y+=12}
  }
  else if attackTime>=41 and attackTime<=50 //Pull back
  {
    if moveCycle=1 {x+=12}
    else if moveCycle=2 {x-=12; y+=9.6}
    else if moveCycle=3 {x+=12; y+=9.6}
    else if moveCycle=4 {x-=12}
    else if moveCycle=5 {y-=12}
  }
  else if attackTime>=51 and attackTime<=60
  {
    colG+=15; colB+=15
    if attackTime=60 {colR=255; colG=255; colB=255}
    baseColor=make_color_rgb(colR,colG,colB)
    image_blend=baseColor
  }
  else if attackTime>=65
  {
    moveTime=1000
    attackCycle=2
    flythrough+=1
    attackTime=0
  }
}
else if attackCycle=2 //-------------------- [BLUE] Projectile Spam --------------------
{
  if attackTime>=1 and attackTime<=10
  {
    colR-=15; colG-=15
    baseColor=make_color_rgb(colR,colG,colB)
    image_blend=baseColor
  }
  else if attackTime>=30 and attackTime<=90
  {
    if attackTime mod 10=0
    {
      playSound(global.snd_LightballSpread,0,0.93,25000)
      var tNewAttack,tDir;
      bulletStorm+=1
      tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
      if bulletStorm mod 2=0 {tDir+=random_range(-10,10)}
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sFireEyeFire; tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100
      tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=300; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
      tNewAttack.direction=tDir; tNewAttack.bulletSpeed=7; tNewAttack.depth=26
    }
  }
  else if attackTime>=91 and attackTime<=100
  {
    colR+=15; colG+=15
    if attackTime=100 {colR=255; colG=255; colB=255}
    baseColor=make_color_rgb(colR,colG,colB)
    image_blend=baseColor
  }
  else if attackTime>=105
  {
    moveTime=1000
    bulletStorm=0
    attackCycle=3
    flythrough+=1
    attackTime=0
  }
}
else if attackCycle=3 //-------------------- [GREEN] Summon 'Forgotten Spawns' --------------------
{
  if attackTime>=1 and attackTime<=10
  {
    colR-=15; colB-=15
    baseColor=make_color_rgb(colR,colG,colB)
    image_blend=baseColor
  }
  else if attackTime>=31 and attackTime<=200
  {
    if attackTime mod 7=0
    {
      var tNewEnemy,tXX,tYY;
      tXX=0; tYY=0
      if spawnAmt=0 {tXX=-40; tYY=-40}
      else if spawnAmt=1 {tXX=40; tYY=-40}
      else if spawnAmt=2 {tXX=-40; tYY=40}
      else if spawnAmt=3 {tXX=40; tYY=40}
      tNewEnemy=instance_create(x+tXX,y+tYY,oPT_ForgottenSpawn)
      spawnAmt+=1
      if spawnAmt>=maxSpawn {attackTime=205}
    }
  }
  else if attackTime>=201 and attackTime<=210
  {
    colR+=15; colB+=15
    if attackTime=210 {colR=255; colG=255; colB=255}
    baseColor=make_color_rgb(colR,colG,colB)
    image_blend=baseColor
  }
  else if attackTime>=215
  {
    moveTime=1000
    attackCycle=1
    spawnAmt=0
    flythrough+=1
    attackTime=0
  }
}

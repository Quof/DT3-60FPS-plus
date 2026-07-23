#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=true
bActive=true
image_xscale=-1

//Enemy base statistics
eName="Hexor"
eLevel=40
maxLife=1000
life=maxLife
atkPower=25
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
hitSound=global.snd_ComicHit1
bossProgress=0
activateBoss=2

bCanDash=1
dashMeterMax=10000
dashEnergy=dashMeterMax
dashRecovery=15
dashDuration=0

//Movement Data
movePhase=0
moveProg=0
moveTime=0
moveCycles=0
moveSpd=0
xSpd=0
ySpd=0

atkChoice=0
atk_FallingSpikesTime=0
atk_FallingSpikesActive=0

centralPointX=320
centralPointY=224

//Attack Data
atkPhase=0
atkProg=0
atkTime=0
atkCycles=0
spawnX=0; spawnY=0

//Misc Data
xCenter=240
yGround=288
roomSpan=240

convoSequence=0
convoTime=0

jeremyText=""
chaoText=""
devText=""

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with oPlayer1
{
  mask_index=sJF_HitBox
  runAcc=7.7
  initialJumpAcc=-7.6
  jumpTimeTotal=22
  dashRecovery=35
  modDashRecharge=0
  bCanTakeDamage=1
}

global.pMaxLife=1000
global.pLife=global.pMaxLife
oPlayer1.maxLife=global.pMaxLife
oPlayer1.life=global.pMaxLife
global.bCanGameOver=1
instance_create(0,0,oFinalHUD)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and life>0
  {
    //==================== MOVEMENT ====================
    if dashDuration>0
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sH_AfterImage; tAfterI.image_index=image_index; tAfterI.image_blend=c_white
      tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.06
      tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0
      tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
      dashDuration-=1
    }
    else //Dash energy recovery
    {
      if dashEnergy<dashMeterMax
      {
        dashEnergy+=dashRecovery
        if dashEnergy>dashMeterMax {dashEnergy=dashMeterMax}
      }
    }

    moveTime+=1
    if movePhase=0 //Selective positioning
    {
      if moveTime>=120
      {
        moveProg+=1
        if moveProg=1 {centralPointX=384; centralPointY=192}
        else if moveProg=2 {centralPointX=240; centralPointY=100}
        else if moveProg=3 {centralPointX=96; centralPointY=192}
        else if moveProg=4 {centralPointX=160; centralPointY=240}
        else if moveProg=5 {centralPointX=320; centralPointY=240; moveProg=0}
        moveTime=0
      }

      myDist=point_distance(x,y,centralPointX,centralPointY)
      myDist=round(myDist/16)
      if myDist>6 {myDist=6}
      if myDist<2.5 {myDist=2.5}
      maxSpeed=myDist

      if x>centralPointX
      {
        if hspeed>-maxSpeed {hspeed-=0.4}
        else {hspeed=-maxSpeed}
      }
      else if x<centralPointX
      {
        if hspeed<maxSpeed {hspeed+=0.4}
        else {hspeed=maxSpeed}
      }
      if y>centralPointY
      {
        if vspeed>-maxSpeed {vspeed-=0.4}
        else {vspeed=-maxSpeed}
      }
      else if y<centralPointY
      {
        if vspeed<maxSpeed {vspeed+=0.4}
        else {vspeed=maxSpeed}
      }

      if point_distance(x,y,centralPointX,centralPointY)<=6.5 and dashDuration=0 //Find point and stop
      {
        x=centralPointX; y=centralPointY
        hspeed=0; vspeed=0; xSpd=0; ySpd=0
      }
    }

    //==================== SEQUENCE ====================
    atkTime+=1
    if atkPhase=0
    {
      if atkProg=0
      {
        if atkTime=110 {atkChoice=1; event_user(0)}
        else if atkTime=180 {atkChoice=2; event_user(0)}
        else if atkTime=220 {atk_FallingSpikesActive=1}
        else if atkTime>=261
        {
          moveCycles+=1
          if moveCycles=2 {moveCycles=0; atkProg=1}
          atkTime=0
        }

        if lifePercent<=0.8 //Next phase check
        {
          msgCreate(60,80,"Hexor","Try punching these!",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
          atkTime=0; atkProg=0; moveCycles=0; atkPhase=1
        }
      }
      else if atkProg=1
      {
        if atkTime=100 {atkChoice=3; event_user(0)}
        else if atkTime>=120
        {
          atkTime=-20; atkProg=0
        }
      }
    }
    else if atkPhase=1
    {
      if atkTime=30 {spawnX=448; spawnY=176; atkChoice=4; event_user(0)}
      else if atkTime=50 {spawnX=448; spawnY=160; atkChoice=4; event_user(0)}
      else if atkTime=70 {spawnX=448; spawnY=144; atkChoice=4; event_user(0)}
      else if atkTime=90 {spawnX=448; spawnY=128; atkChoice=4; event_user(0)}
      else if atkTime=150 {spawnX=32; spawnY=176; atkChoice=4; event_user(0)}
      else if atkTime=170 {spawnX=32; spawnY=160; atkChoice=4; event_user(0)}
      else if atkTime=190 {spawnX=32; spawnY=144; atkChoice=4; event_user(0)}
      else if atkTime=210 {spawnX=32; spawnY=128; atkChoice=4; event_user(0)}
      else if atkTime=250 {atk_FallingSpikesActive=1}
      else if atkTime>=280
      {
        atkTime=0
      }

      if lifePercent<=0.6 //Next phase check
      {
        atkTime=0; atkProg=0; moveCycles=0; atkPhase=2
      }
    }
    else if atkPhase=2
    {
      if atkProg=0
      {
        if atkTime=1
        {
          msgCreate(60,80,"Hexor","This isn't working. I can just turn on invulnerability to your attacks though.",0,2,oMessagePerson,0)
          newMessage.fadingTime=130
          for(i=0;i<6;i+=1)
          {
            resType[i]=1
          }
        }
        else if atkTime=130
        {
          msgCreate(60,80,"Jeremy","Why didn't you do that at the start? And you know I can just remove that, right?",0,2,oMessagePerson,0)
          newMessage.fadingTime=130
        }
        else if atkTime=260
        {
          msgCreate(60,80,"Hexor","Fine...",0,0,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=320
        {
          msgCreate(60,80,"Hexor","If I can't beat you like this, then...",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
        }
        else if atkTime>=400 //To Pong
        {
          global.recAreaTrans+=1
          global.finalBossHP=life
          newLifeAmt=round((oPlayer1.maxLife-oPlayer1.life)/2)
          oPlayer1.life+=newLifeAmt
          global.pLife=oPlayer1.life
          global.jeremySuperEnergy=oPlayer1.jeremySuperEnergy
          transition_steps=1; transition_kind=21
          room_goto(rDistFinal_Pong)
        }

        if atkTime=70
        {
          atkChoice=1; event_user(0)
          atkChoice=2; event_user(0)
          atkChoice=3; event_user(0)
        }
      }
    }

    //LINGERING ATTACKS
    event_user(1)

    //CONVO SEQUENCE
    if convoSequence=0 and lifePercent<=0.97
    {
      msgCreate(60,80,"Jeremy","Using the dash now?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
      convoSequence+=1
    }
    else if convoSequence=1
    {
      convoTime+=1
      if convoTime=60
      {
        msgCreate(60,80,"Hexor","Might as well.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if convoTime=120
      {
        convoTime=0; convoSequence+=1
      }
    }
    else if convoSequence=2 and lifePercent<=0.92
    {
      msgCreate(60,80,"Hexor","I've blocked your escape.",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
      convoSequence+=1
    }
    else if convoSequence=3
    {
      convoTime+=1
      if convoTime=60
      {
        msgCreate(60,80,"Jeremy","Makes no difference.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if convoTime=120
      {
        convoTime=0; convoSequence+=1
      }
    }
    else if convoSequence=4 and lifePercent<=0.86
    {
      msgCreate(60,80,"Hexor","I've been blocking your functions.",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
      convoSequence+=1
    }
    else if convoSequence=5
    {
      convoTime+=1
      if convoTime=60
      {
        msgCreate(60,80,"Jeremy","And I said it makes no difference. I'm not leaving.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if convoTime=150
      {
        convoTime=0; convoSequence+=1
      }
    }
    else if convoSequence=6 and lifePercent<=0.72
    {
      msgCreate(60,80,"Jeremy","What's wrong? Ah right, I blocked most everything else you can do.",0,2,oMessagePerson,0)
      newMessage.fadingTime=100
      convoSequence+=1
    }
    else if convoSequence=7
    {
      convoTime+=1
      if convoTime=100
      {
        msgCreate(60,80,"Hexor","I'll break it soon enough.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if convoTime=160
      {
        convoTime=0; convoSequence+=1
      }
    }
  }

  enemyStepEvent()
}
else
{
  hspeed=0; vspeed=0
  speed=0
}

/*
movePhase,moveProg,moveTime,moveCycles,moveSpd,xSpd,ySpd
centralPointX=320
centralPointY=224
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if dashDuration=0 and bCanTakeDamage=true
{
  if bCanDash=1
  {
    if movePhase=0 //Stationary
    {
      if hspeed=0 and vspeed=0 and dashEnergy>=2000
      {
        hspeed=choose(-6,-4,4,6); vspeed=choose(-6-4,4,6)
        dashEnergy-=2000
        dashDuration=10
      }
      else {event_inherited()}
    }
  }
  else {event_inherited()}
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//==================== ATTACKS ====================
if atkChoice=1 //---------- Closing Spikes ----------
{
  playSound(global.snd_OrbThrow,0,1,42200)
  var tNewAtk;
  for(i=0;i<6;i+=1)
  {
    tNewAtk=instance_create(x,y-52+(i*18),oHexor_RedSpikeA)
    if i mod 2=0 {tNewAtk.type=0} else {tNewAtk.type=1}
  }
}
else if atkChoice=2 //---------- Lingering Spike ----------
{
  var tNewAtk;
  tNewAtk=instance_create(x,y,oHexor_RedSpikeB)
  tNewAtk.atkDelay=25; tNewAtk.atkLinger=150; tNewAtk.image_xscale=1.5; tNewAtk.image_yscale=1.5
}
else if atkChoice=3 //---------- Wall of Spikes ----------
{
  playSound(global.snd_Wave,0,1,10000)
  var tNewAtk;
  for(i=0;i<36;i+=1)
  {
    for(ii=0;ii<10;ii+=1)
    {
      tNewAtk=instance_create(8+(i*14),128+(ii*14),oHexor_RedSpikeB)
      tNewAtk.atkDelay=40; tNewAtk.atkLinger=50; tNewAtk.image_xscale=1.5; tNewAtk.image_yscale=1.5; tNewAtk.depth=21
    }
  }
}
else if atkChoice=4 //---------- Machine Spike (Aimed) ----------
{
  playSound(global.snd_PortalCreate,0,0.92,40000+random(8000))
  var tNewAtk;
  tNewAtk=instance_create(spawnX,spawnY,oHexor_MachinePartA)
  tNewAtk.atkDelay=25; tNewAtk.type=0; tNewAtk.atkPower=atkPower
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//==================== LINGERING ATTACKS ====================
if atk_FallingSpikesActive=1 //---------- Falling Spikes ----------
{
  atk_FallingSpikesTime+=1
  if atk_FallingSpikesTime mod 5=0
  {
    var tNewAtk;
    tNewAtk=instance_create(x,y,oHexor_RedSpikeC)
  }
  if atk_FallingSpikesTime>=60
  {
    atk_FallingSpikesTime=0
    atk_FallingSpikesActive=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Draw Hex
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

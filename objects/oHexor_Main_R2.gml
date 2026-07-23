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
life=global.finalBossHP
atkPower=25
stunResist=50
resType[0]=1
resType[2]=1
resType[5]=5
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
bossProgress=0
activateBoss=2

bCanDash=0
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

centralPointX=352
centralPointY=128

//Attack Data
atkPhase=0
atkProg=0
atkTime=0
atkCycles=0
timesHitWithOrb=0
spawnX=0; spawnY=0

extraAtkTime=0

orbHitMax=5
orbSpdInc=1

//Misc Data
xCenter=240
yGround=288
roomSpan=240

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
}

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
    //==================== SEQUENCE ====================
    atkTime+=1
    if atkPhase=0
    {
      if atkProg=0 //Intro dialogue
      {
        if atkTime=35
        {
          msgCreate(60,80,"Hexor","I'm still invulnerable to your attacks.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if atkTime=105
        {
          msgCreate(60,80,"Jeremy","We'll see.",0,1,oMessagePerson,0)
          newMessage.fadingTime=50
        }
        else if atkTime=115 {life=maxLife}
        else if atkTime=175
        {
          msgCreate(60,80,"Jeremy","Hey, what are you doing?",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=235
        {
          msgCreate(60,80,"Hexor","Simply being unbeatable.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime>=295
        {
          atkTime=0; atkProg=1
        }
      }
      else if atkProg=1 //Use Ganon Orb (First orb)
      {
        if atkTime=30
        {
          atkChoice=1; event_user(0)
          atkTime=0; atkProg=2
        }

        if bossProgress=1
        {
          atkTime=0; atkProg=3
        }
      }
      else if atkProg=2 //Wait for Ganon Orb to no longer exist (First orb)
      {
        if !instance_exists(oHexor_GanonOrb)
        {
          atkTime=0; atkProg=1
        }
      }
      else if atkProg=3 //Short dialogue
      {
        if atkTime=5
        {
          msgCreate(60,80,"Jeremy","Played that one too.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=65
        {
          msgCreate(60,80,"Hexor","How about this next one.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=110
        {
          extraAtkTime=100
          atkTime=0; atkProg=4
        }
      }
      else if atkProg=4 //Use Ganon Orb (All other uses)
      {
        if atkTime=30
        {
          atkChoice=1; event_user(0)
          atkTime=0; atkProg=5
        }

        if bossProgress=5
        {
          extraAtkTime=0
          atkTime=0; atkProg=6
        }
      }
      else if atkProg=5 //Wait for Ganon Orb to no longer exist (All other uses)
      {
        if !instance_exists(oHexor_GanonOrb)
        {
          atkTime=0; atkProg=4
        }
      }
      else if atkProg=6 //Second dialogue
      {
        if atkTime=50
        {
          msgCreate(60,80,"Hexor","One last time.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=80 {extraAtkTime=100}
        else if atkTime>=100
        {
          atkTime=0; atkProg=7
        }
      }
      else if atkProg=7 //Use Ganon Orb (Final)
      {
        if atkTime=30
        {
          atkChoice=1; event_user(0)
          atkTime=0; atkProg=8
        }

        if bossProgress=6
        {
          extraAtkTime=0

          global.gamePaused=true
          oEvCh21MainA.sceneProgress=1
          atkTime=0; atkProg=9
        }
      }
      else if atkProg=8 //Wait for Ganon Orb to no longer exist (Final)
      {
        if !instance_exists(oHexor_GanonOrb)
        {
          atkTime=0; atkProg=7
        }
      }

      if extraAtkTime>=100 //2nd orb
      {
        extraAtkTime+=1
        if bossProgress=1
        {
          if extraAtkTime=101
          {
            spawnX=400; spawnY=272; myDir=180
            atkChoice=2; event_user(0)
          }
          else if extraAtkTime>=240 {extraAtkTime=100}
        }
        else if bossProgress>=2 and bossProgress<=3 //3rd and 4th orb
        {
          if extraAtkTime=101
          {
            spawnX=400; spawnY=272; myDir=180
            atkChoice=2; event_user(0)
          }
          else if extraAtkTime=130
          {
            spawnX=80; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=200
          {
            spawnX=384; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime>=240 {extraAtkTime=100}
        }
        else if bossProgress=4 //5th orb
        {
          if extraAtkTime=101
          {
            spawnX=80; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=160
          {
            spawnX=384; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime>=230 {extraAtkTime=100}
        }
        else //Final Orb
        {
          if extraAtkTime=101
          {
            spawnX=96; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=140
          {
            spawnX=160; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=180
          {
            spawnX=240; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=220
          {
            spawnX=304; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=260
          {
            spawnX=384; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime>=290 {extraAtkTime=100}
        }
      }
    }
  }

  if timesHitWithOrb=1 and bossProgress=0
  {
    orbHitMax=6
    orbSpdInc=1.5
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=2 and bossProgress=1
  {
    orbHitMax=10
    orbSpdInc=0.75
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=3 and bossProgress=2
  {
    orbHitMax=8
    orbSpdInc=1.5
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=4 and bossProgress=3
  {
    orbHitMax=9
    orbSpdInc=1.6
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=5 and bossProgress=4 //To final
  {
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=6 and bossProgress=5
  {
    bossProgress+=1
  }

  enemyStepEvent()
}
else
{
  hspeed=0; vspeed=0
  speed=0
}
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
if atkChoice=1 //---------- Ganon Orb ----------
{
  var tNewAtk;
  tNewAtk=instance_create(x,y-32,oHexor_GanonOrb)
  tNewAtk.spdInc=orbSpdInc; tNewAtk.hitMax=orbHitMax
}
else if atkChoice=2 //---------- Machine Spike (Not Aimed) ----------
{
  playSound(global.snd_PortalCreate,0,0.92,40000+random(8000))
  tNewAtk=instance_create(spawnX,spawnY,oHexor_MachinePartA)
  tNewAtk.atkDelay=25; tNewAtk.myDir=myDir; tNewAtk.type=1; tNewAtk.atkPower=atkPower*2
}
else if atkChoice=3 //---------- Machine Spike (Aimed) ----------
{
  playSound(global.snd_PortalCreate,0,0.92,40000+random(8000))
  tNewAtk=instance_create(spawnX,spawnY,oHexor_MachinePartA)
  tNewAtk.atkDelay=25; tNewAtk.type=0; tNewAtk.atkPower=atkPower*2
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Draw Hex
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

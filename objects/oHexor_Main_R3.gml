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
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[0]=3
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

bWindSound=0
windSoundRep=0

//Movement Data
movePhase=0
moveProg=0
moveTime=0
moveCycles=0
moveSpd=0
xSpd=0
ySpd=0

//Attack Data
atkPhase=0
atkProg=0
atkTime=0
atkCycles=0

//Misc Data
xCenter=360
yGround=304
roomSpan=360

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
  runAcc=1.3
  initialJumpAcc=-2.8
  jumpTimeTotal=15
  dashRecovery=35
  modDashRecharge=0
}
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
    //Push Jeremy back
    oPlayer1.xAcc=-0.3

    if oPlayer1.x>=128 and atkPhase=0
    {
      msgCreate(60,80,"Jeremy","Jerry and I would find this fun.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; atkPhase+=1
    }
    else if oPlayer1.x>=224 and atkPhase=1
    {
      msgCreate(60,80,"Jeremy","I won't try to explain it to you.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; atkPhase+=1
    }
    else if oPlayer1.x>=320 and atkPhase=2
    {
      msgCreate(60,80,"Jeremy","You just wouldn't care.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; atkPhase+=1
    }
    else if oPlayer1.x>=448 and atkPhase=3
    {
      msgCreate(60,80,"Jeremy","Don't answer then. We're done talking anyway.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; atkPhase+=1
    }

    if atkPhase=4
    {
      if life<maxLife
      {
        global.gamePaused=true
        oEvCh21MainA.sceneProgress=11
        atkPhase+=1
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

if bWindSound=1
{
  if windSoundRep=0
  {
    playSound(global.snd_WindBlow,0,0.97,10000)
    windSoundRep=50
  }
  else {windSoundRep-=1}
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Draw Hex
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

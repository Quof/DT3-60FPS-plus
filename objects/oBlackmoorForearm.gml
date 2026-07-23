#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- BLACKMOOR: FOREARM -----
event_inherited()
bCanTakeDamage=false

//Enemy base statistics
eName="Blackmore"
eLevel=13
maxLife=100
life=maxLife
atkPower=oBlackmoorMain.atkPower
affiliation=9
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0
neutralAngle=240+oBlackmoorMain.angleAdj
bendAngle=0
atkAngle=0

bendProg=0
bendSpd=1
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if side=0 {bendSpd=3}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if side=0 //Left (Front)
  {
    x=oBlackmoorMain.bShoulderL.x+lengthdir_x(48,oBlackmoorMain.bShoulderL.image_angle+270)
    y=oBlackmoorMain.bShoulderL.y+lengthdir_y(48,oBlackmoorMain.bShoulderL.image_angle+270)
  }
  else if side=1 //Right (Back)
  {
    x=oBlackmoorMain.bShoulderR.x+lengthdir_x(48,oBlackmoorMain.bShoulderR.image_angle+270)
    y=oBlackmoorMain.bShoulderR.y+lengthdir_y(48,oBlackmoorMain.bShoulderR.image_angle+270)
  }
  image_angle=neutralAngle+bendAngle+atkAngle

  if oBlackmoorMain.bErratic=1
  {
    if bendProg=0
    {
      bendSpd-=0.5
      if bendSpd<=-4 {bendProg=1}
    }
    else if bendProg=1
    {
      bendSpd+=0.5
      if bendSpd>=4 {bendProg=0}
    }
    bendAngle+=bendSpd
  }
  enemyStepEvent()
}

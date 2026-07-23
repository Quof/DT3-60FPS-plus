#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- BLACKMOOR: SHOULDER -----
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
neutralAngle=295+oBlackmoorMain.angleAdj
bendAngle=0
atkAngle=0

bendProg=1
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
    //x=oBlackmoorMain.x-12
    //y=oBlackmoorMain.y-61
    x=oBlackmoorMain.x+lengthdir_x(62,oBlackmoorMain.image_angle+90)
    y=oBlackmoorMain.y+lengthdir_y(62,oBlackmoorMain.image_angle+90)
  }
  else if side=1 //Right (Back)
  {
    //x=oBlackmoorMain.x-33
    //y=oBlackmoorMain.y-54
    x=oBlackmoorMain.x+lengthdir_x(68,oBlackmoorMain.image_angle+110)
    y=oBlackmoorMain.y+lengthdir_y(68,oBlackmoorMain.image_angle+110)
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

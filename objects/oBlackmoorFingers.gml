#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- BLACKMOOR: FINGERS -----
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
neutralAngle=270+oBlackmoorMain.angleAdj
bendAngle=0
fingerOffset=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  fingerOffset=-30
  neutralAngle=240+oBlackmoorMain.angleAdj
}
else if type=1
{
  sprite_index=sBlackmoorFingerB
  fingerOffset=-10
  neutralAngle=260+oBlackmoorMain.angleAdj
}
else if type=2
{
  sprite_index=sBlackmoorFingerC
  fingerOffset=10
  neutralAngle=280+oBlackmoorMain.angleAdj
}
else if type=3
{
  sprite_index=sBlackmoorFingerD
  fingerOffset=30
  neutralAngle=300+oBlackmoorMain.angleAdj
}
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
    x=oBlackmoorMain.bHandL.x+lengthdir_x(13,oBlackmoorMain.bHandL.image_angle+fingerOffset+270)
    y=oBlackmoorMain.bHandL.y+lengthdir_y(13,oBlackmoorMain.bHandL.image_angle+fingerOffset+270)
    image_angle=oBlackmoorMain.bHandL.image_angle+neutralAngle+bendAngle
    bendAngle+=sin(oBlackmoorMain.fingerMove[0]/2+(type*2))
  }
  else if side=1 //Right (Back)
  {
    x=oBlackmoorMain.bHandR.x+lengthdir_x(13,oBlackmoorMain.bHandR.image_angle+fingerOffset+270)
    y=oBlackmoorMain.bHandR.y+lengthdir_y(13,oBlackmoorMain.bHandR.image_angle+fingerOffset+270)
    image_angle=oBlackmoorMain.bHandR.image_angle+neutralAngle+bendAngle
    bendAngle+=sin(oBlackmoorMain.fingerMove[1]/2+(type*2))
  }
  enemyStepEvent()
}

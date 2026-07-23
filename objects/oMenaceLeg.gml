#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: LEG -----
event_inherited()
bCanTakeDamage=false

//Enemy base statistics
eName="Menace"
eLevel=11
maxLife=100
life=maxLife
atkPower=oMenaceMain.atkPower
affiliation=3
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0
neutralAngle=225+oMenaceMain.angleAdj
bendAngle=0
deathFlail=0
xVel=0
yVel=0
spinSpd=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if side=0 //Left (Front)
{
  x=oMenaceMain.x+46
  y=oMenaceMain.y+103
}
else if side=1 //Right (Back)
{
  x=oMenaceMain.x-15
  y=oMenaceMain.y+100
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if deathFlail=1
  {
    hspeed=xVel
    vspeed=yVel
  }
  else
  {
    image_angle=neutralAngle+bendAngle

    /*if side=0 //Left (Front)
      image_angle=point_direction(x,y,oMenaceMain.bCalfL.x,oMenaceMain.bCalfL.y)+neutralAngle+bendAngle
    else if side=1 //Right (Back)
      image_angle=point_direction(x,y,oMenaceMain.bCalfR.x,oMenaceMain.bCalfR.y)+neutralAngle+bendAngle*/
  }
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}

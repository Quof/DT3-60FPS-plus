#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: SHOULDER -----
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
neutralAngle=270+oMenaceMain.angleAdj
bendAngle=0
deathFlail=0
xVel=0
yVel=0
spinSpd=0
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
    if side=0 //Left (Front)
    {
      x=oMenaceMain.x-4
      y=oMenaceMain.y-6
    }
    else if side=1 //Right (Back)
    {
      x=oMenaceMain.x-26
      y=oMenaceMain.y-12
    }
    image_angle=neutralAngle+bendAngle
  }
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}

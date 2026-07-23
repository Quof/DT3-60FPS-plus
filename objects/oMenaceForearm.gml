#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: FOREARM -----
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
neutralAngle=210+oMenaceMain.angleAdj
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
      x=oMenaceMain.bShoulderL.x+lengthdir_x(82,oMenaceMain.bShoulderL.image_angle+270)
      y=oMenaceMain.bShoulderL.y+lengthdir_y(82,oMenaceMain.bShoulderL.image_angle+270)
    }
    else if side=1 //Right (Back)
    {
      x=oMenaceMain.bShoulderR.x+lengthdir_x(82,oMenaceMain.bShoulderR.image_angle+270)
      y=oMenaceMain.bShoulderR.y+lengthdir_y(82,oMenaceMain.bShoulderR.image_angle+270)
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

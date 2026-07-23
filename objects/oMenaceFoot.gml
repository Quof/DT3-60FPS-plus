#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: FOOT -----
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
      x=oMenaceMain.bCalfL.x+lengthdir_x(94,oMenaceMain.bCalfL.image_angle+270)
      y=oMenaceMain.bCalfL.y+lengthdir_y(94,oMenaceMain.bCalfL.image_angle+270)
    }
    else if side=1 //Right (Back)
    {
      x=oMenaceMain.bCalfR.x+lengthdir_x(94,oMenaceMain.bCalfR.image_angle+270)
      y=oMenaceMain.bCalfR.y+lengthdir_y(94,oMenaceMain.bCalfR.image_angle+270)
    }
  }
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}

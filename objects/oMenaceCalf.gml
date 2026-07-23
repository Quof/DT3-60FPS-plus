#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: CALF -----
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
neutralAngle=290+oMenaceMain.angleAdj
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
      x=oMenaceMain.bLegL.x+lengthdir_x(122,oMenaceMain.bLegL.image_angle+270)
      y=oMenaceMain.bLegL.y+lengthdir_y(122,oMenaceMain.bLegL.image_angle+270)
    }
    else if side=1 //Right (Back)
    {
      x=oMenaceMain.bLegR.x+lengthdir_x(122,oMenaceMain.bLegR.image_angle+270)
      y=oMenaceMain.bLegR.y+lengthdir_y(122,oMenaceMain.bLegR.image_angle+270)
    }
    image_angle=neutralAngle

    /*if side=0 //Left (Front)
      image_angle=point_direction(x,y,oMenaceMain.bFootL.x,oMenaceMain.bFootL.y)+neutralAngle
    else if side=1 //Right (Back)
      image_angle=point_direction(x,y,oMenaceMain.bFootR.x,oMenaceMain.bFootR.y)+neutralAngle*/
  }
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}

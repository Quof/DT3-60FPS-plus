#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: HEAD -----
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
bendAngle=0
laserWarn=0
cirRad=32
circleAlpha=1
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
    x=oMenaceMain.x-62
    y=oMenaceMain.y-54
    image_angle=bendAngle

    if laserWarn>0
    {
      laserWarn+=1
      circleAlpha-=0.06
      cirRad-=1
      if laserWarn>=15
      {
        laserWarn=0
        cirRad=32
        circleAlpha=1
      }
    }
  }
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if laserWarn>0
{
  draw_set_alpha(circleAlpha)
  draw_set_color(c_red)
  for(i=0;i<12;i+=1)
  {
    draw_circle(x,y,cirRad*(i+1),1)
  }
}

event_inherited()

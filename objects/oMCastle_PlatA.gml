#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()

deathCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if x>xstart
  {
    if xVel>-4 {xVel-=0.1}
  }
  else if x<xstart
  {
    if xVel<4 {xVel+=0.1}
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="SHOT" and other.y>=y+20
{
  var tShotDir; //60fps change (added): shots move with _direction now, so their built-in direction is always 0
  tShotDir=other.direction //60fps change (added)
  with other {if variable_local_exists("_direction") {tShotDir=_direction}} //60fps change (added)
  //if other.direction=0
  if tShotDir=0 //60fps change: every shot counted as going right, so the platform could only be pushed right

  {
    if x<xstart+128
    {
      if xVel>1 {xVel=3.5}
      else if xVel<0 {xVel=0.5}
      else {xVel=2}
    }
  }
  //else if other.direction=180
  else if tShotDir=180 //60fps change: see above
  {
    if x>xstart-128
    {
      if xVel<-1 {xVel=-3.5}
      else if xVel>0 {xVel=-0.5}
      else {xVel=-2}
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sMCastle_ChainA,0,xstart,ystart-128)
draw_set_color(c_black)
draw_set_alpha(0.75)
draw_line_width(xstart,ystart-128,x,y,2)
draw_self()

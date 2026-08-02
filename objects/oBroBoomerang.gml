#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: myThrower,bulletSpeed
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

throwProg=0
throwTime=0
turnSpd=5

direction=0
speed=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  throwTime+=1*gDeltaTime
  if throwProg=0 //---------- Fly straight ----------
  {
    if throwTime>=15 {throwTime=0; throwProg+=1}
  }
  else if throwProg=1 //---------- Arc ----------
  {
    if type=1 //Thrown right
    {
     // direction-=turnSpd*gDeltaTime
      _direction-=turnSpd*gDeltaTime
    }
    else if type=-1 //Thrown left
    {
      //direction+=turnSpd*gDeltaTime
      _direction+=turnSpd*gDeltaTime
    }
    if throwTime>=30
    {
      if instance_exists(myThrower)
      {
        myTargetX=myThrower.x; myTargetY=myThrower.y
      }
      else
      {
        myTargetX=x; myTargetY=y+432
      }
      throwTime=0; throwProg+=1
    }
  }
  else if throwProg=2 //---------- Fly back to thrower ----------
  {
    if throwTime>=90 {instance_destroy()}
    if instance_exists(myThrower)
    {
      myPoint=point_direction(x,y,myThrower.x,myThrower.y)
      if point_distance(x,y,myThrower.x,myThrower.y)<=4 {instance_destroy()}
    }
    else
    {
      myPoint=point_direction(x,y,myTargetX,myTargetY)
    }

    /*var tDiff;
    tDiff=angle_difference(myPoint,_direction)
    if abs(tDiff)<=turnSpd
    {_direction=myPoint}
    else
    {_direction+=sign(tDiff)*turnSpd*gDeltaTime} */

    turn_toward_directionUnderscore(myPoint, turnSpd)
  }

  if throwProg>1
  {
    if !instance_exists(myThrower) {instance_destroy()}
  }
  _speed=bulletSpeed
  speed=0
  x += cos(degtorad(_direction)) * _speed *gDeltaTime
  y -= sin(degtorad(_direction)) * _speed *gDeltaTime
  image_angle-=20*type*gDeltaTime
}
else {speed=0; _speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()

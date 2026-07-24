#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"

fireProg=0
targetY=oPlayer1.y-26

_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false //&& gDeltaDoTicks != 0
{
  if fireProg=0
  {
    if y<targetY
    {
      y+=bulletSpeed*gDeltaTime
      if baseDir=0
        //direction=315
        _direction=315
      else
       // direction=225
        _direction=225
    }
    else
    {
      y-=bulletSpeed*gDeltaTime
      if baseDir=0
        //direction=45
        _direction=45
      else
        //direction=135
        _direction=135
    }

    if point_distance(0,y,0,targetY)<3
    {
      //direction=baseDir
      _direction=baseDir
      fireProg+=1*gDeltaTime
    }
  }

  //speed=bulletSpeed
  _speed=bulletSpeed*gDeltaTime
  x += cos(degtorad(_direction)) * _speed
  y -= sin(degtorad(_direction)) * _speed

  //image_angle=direction
  image_angle=_direction
}
else
  {speed=0
  _speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()

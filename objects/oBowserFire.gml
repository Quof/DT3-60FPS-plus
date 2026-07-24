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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks != 0
{
  if fireProg=0
  {
    if y<targetY
    {
      y+=bulletSpeed
      if baseDir=0
        direction=315
      else
        direction=225
    }
    else
    {
      y-=bulletSpeed
      if baseDir=0
        direction=45
      else
        direction=135
    }

    if point_distance(0,y,0,targetY)<3
    {
      direction=baseDir
      fireProg+=1
    }
  }

  speed=bulletSpeed
  image_angle=direction
}
else
  speed=0
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()

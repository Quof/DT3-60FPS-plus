#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="SHOT"
weaponTag=120
global.recAtkNum+=1
stunTime=1
turnSpd=6
lifeTime=60
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if instance_exists(oCHAOS_Assault)
  {
    myTarget=instance_nearest(x,y,oCHAOS_Assault)
    //direction=point_direction(x,y,myTarget.x,myTarget.y)
    turn_toward_directionUnderscore(point_direction(x,y,myTarget.x,myTarget.y),turnSpd)
  }

  image_angle=_direction
  _speed=bulletSpeed

  lifeTime-=1*gDeltaTime
  if lifeTime<=0 {instance_destroy()}
}
else {_speed=0}
correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()

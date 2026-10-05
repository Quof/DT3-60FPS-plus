#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.5

damageType="SHOT"
weaponTag=120
global.recAtkNum+=1
stunTime=1

_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  bulletSpeed=scrTickAcc(bulletSpeed,0.25*(bulletSpeed<10),0) //speed up per 30fps tick (scrTickAcc)
  x+=(bulletSpeed+scrTickAccB(0))*gDeltaTime
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()

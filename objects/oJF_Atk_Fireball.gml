#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: myDir
event_inherited()
image_speed=0.33

damageType="ELEMENTAL"
weaponTag=160
atkPower=19
global.recAtkNum+=1

myScale=1.5
decay=60
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_xscale=myScale*myDir; image_yscale=myScale

  x+=7*myDir

  decay-=1
  if decay<=0 {instance_destroy()}
}

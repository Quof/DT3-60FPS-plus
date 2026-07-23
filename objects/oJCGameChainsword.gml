#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="PIERCE"
weaponTag=51
atkLv=global.stCGame_B[0]
atkPower=25+(global.stJGame_C[1]*3)
atkPower=weaponDmgMod(1,atkPower)
stunTime=3
bCanHitSwitch=0
bCanPierce=1
weaponRehitTime=30
flySpd=13
decayTime=75

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible=1
if type=1
{
  image_angle=315
  direction=315
}
else
{
  image_angle=225
  direction=225
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  speed=flySpd

  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
else {speed=0}

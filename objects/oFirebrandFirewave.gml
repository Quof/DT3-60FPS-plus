#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.4

damageType="ELEMENTAL"
weaponTag=108
atkPower=40
stunTime=1
bCanPierce=1
weaponRehitTime=8
lifeTime=50
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_xscale+=0.02; image_yscale+=0.02
  image_alpha-=0.005
  lifeTime-=1
  if lifeTime>=10 and lifeTime<=1 {image_alpha-=0.05}
  if lifeTime<=0 {instance_destroy()}
}

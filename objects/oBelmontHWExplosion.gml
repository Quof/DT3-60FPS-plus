#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_xscale=2.5
image_yscale=2.5
damageType="ELEMENTAL"
weaponTag=32
atkLv=global.stBelmont_Holywater[0]
atkPower=round((90+(global.stBelmont_Holywater[0]*2)+global.skillTree[12])*1.25)
atkPower=weaponDmgMod(1,atkPower)
stunTime=15
bCanPierce=1
trailSpd=4


_speed=0
_direction=0
_hspeed=0
_vspeed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bTrail=1
  {
    x+=trailSpd*myDir*gDeltaTime
  }

  image_index+=0.5*gDeltaTime
  if image_index>=image_number-0.1
  {
    instance_destroy()
  }
}

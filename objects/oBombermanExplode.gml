#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=4
image_yscale=4
image_speed=0.5
damageType="EXPLOSION"
weaponTag=42
atkLv=global.stSamus_Bomb[0]
atkPower=65+round(global.stSamus_Bomb[0]*2)+global.skillTree[13]
atkPower=weaponDmgMod(1,atkPower)
stunTime=6
bCanPierce=1
bCanBoost=1
decayTime=10
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  decayTime-=1
  if decayTime<=0
  {
    instance_destroy()
  }
}

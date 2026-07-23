#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.75
damageType="EXPLOSION"
weaponTag=42
atkLv=global.stSamus_Bomb[0]
atkPower=75+round(global.stSamus_Bomb[0]*2)+global.skillTree[13]
atkPower=weaponDmgMod(1,atkPower)
stunTime=13+round(global.stSamus_Bomb[0]/2)
weaponRehitTime=100
bCanPierce=1
bCanHitSwitch=0
image_xscale=0.04
image_yscale=0.04
image_alpha=0.5

colorChange=255
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  image_xscale+=0.04
  image_yscale+=0.04

  if image_xscale=0.72 {colorChange=210}
  if colorChange<255 {colorChange+=3}
  image_blend=make_color_rgb(colorChange,colorChange,colorChange)

  if image_xscale>=0.6 {image_alpha-=0.05}

  if image_xscale>=1.4 {instance_destroy()}
}

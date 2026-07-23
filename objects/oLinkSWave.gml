#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
damageType="NORMAL"
weaponTag=0
atkLv=global.stLink_Sword[0]
atkPower=(100+round(global.stLink_Sword[0]*2.5)+(global.skillTree[8]*6))*0.75
atkPower=weaponDmgMod(0,atkPower)
stunTime=8+global.skillTree[0]
bCanHitSwitch=0
bCanPierce=1
global.recAtkNum+=1
global.stLink_Sword[2]+=1
image_xscale=oPlayer1.image_xscale
image_speed=0
image_index=2
decayTime=13
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_blend=make_color_rgb(random(255),random(255),random(255))
  x+=9*image_xscale
  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}

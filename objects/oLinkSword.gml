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
atkPower=100+round(global.stLink_Sword[0]*2.5)+(global.skillTree[8]*6)
atkPower=weaponDmgMod(0,atkPower)
stunTime=8+global.skillTree[0]
bCanPierce=1
global.recAtkNum+=1
global.stLink_Sword[2]+=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oPlayer1.x
  y=oPlayer1.y
  image_speed=oPlayer1.image_speed
  image_xscale=oPlayer1.image_xscale
}
else
  image_speed=0
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()

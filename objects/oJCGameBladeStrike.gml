#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
damageType="NORMAL"
weaponTag=50
atkLv=global.stCGame_A[0]
atkPower=110+(global.stJGame_C[1]*4)
atkPower=weaponDmgMod(1,atkPower)
stunTime=8
bCanPierce=1
global.recAtkNum+=1
global.stCGame_A[2]+=1
image_xscale=1.1
image_yscale=0.7
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
  x=oPlayer1.x+(32*oPlayer1.image_xscale)
  y=oPlayer1.y-19
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

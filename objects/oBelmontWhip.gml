#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
damageType="NORMAL"
weaponTag=30
atkLv=global.stBelmont_HairWhip[0]
atkPower=105+round(global.stBelmont_HairWhip[0]*3)+(global.skillTree[11]*4)
atkPower=weaponDmgMod(1,atkPower)
stunTime=12+global.skillTree[26]
bCanPierce=1
global.recAtkNum+=1
global.stBelmont_HairWhip[2]+=1
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

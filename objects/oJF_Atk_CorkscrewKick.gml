#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
damageType="NORMAL"
weaponTag=160
atkPower=13
bCanPierce=1
global.recAtkNum+=1

decayTime=18
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  x=oPlayer1.x
  y=oPlayer1.y
  image_xscale=oPlayer1.image_xscale
  image_index=oPlayer1.image_index

  oPlayer1.xVel=10*oPlayer1.image_xscale
  oPlayer1.yVel=7

  decayTime-=1
  if decayTime=15 {oPlayer1.image_index=1}
  if decayTime<=0
  {
    instance_destroy()
  }
}

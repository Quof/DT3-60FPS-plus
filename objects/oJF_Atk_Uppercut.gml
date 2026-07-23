#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
damageType="NORMAL"
weaponTag=160
atkPower=13
bCanPierce=1
global.recAtkNum+=1

myScale=2
image_speed=0.5

decayTime=18
oPlayer1.y-=2
oPlayer1.image_index=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  x=oPlayer1.x+(5*image_xscale)
  y=oPlayer1.y-57
  image_xscale=oPlayer1.image_xscale*myScale
  image_yscale=1.5
  image_speed=0.5

  if image_xscale>0 {image_angle=90}
  else {image_angle=-90}

  oPlayer1.xVel=(1.5*oPlayer1.image_xscale)*(decayTime/3)
  oPlayer1.yVel=-decayTime/1.25

  decayTime-=1
  if decayTime=15 {oPlayer1.image_index=1}
  if decayTime<=0
  {
    instance_destroy()
  }
}
else
  image_speed=0

#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
damageType="NORMAL"
weaponTag=160
atkPower=5
bCanPierce=1
global.recAtkNum+=1

myScale=2

var tFindSpd;
tFindSpd=oPlayer1.atkSpdJeremy/100
mySpd=1-(tFindSpd*6)
image_speed=mySpd
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  x=oPlayer1.x+(20*image_xscale)
  y=oPlayer1.y-46
  image_xscale=oPlayer1.image_xscale*myScale
  image_yscale=1.25
  if image_xscale>0 {image_angle=30}
  else {image_angle=-30}
  image_speed=mySpd
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

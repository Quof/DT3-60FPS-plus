#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
damageType="NORMAL"
weaponTag=160
atkPower=10
bCanPierce=1
global.recAtkNum+=1

myScale=2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
x=oPlayer1.x+(21*image_xscale)
y=oPlayer1.y-40
image_xscale=oPlayer1.image_xscale*myScale
image_yscale=1.25
if image_xscale>0 {image_angle=15}
else {image_angle=-15}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()

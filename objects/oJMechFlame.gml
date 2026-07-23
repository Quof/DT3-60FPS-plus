#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)
image_speed=0.5+random(0.5)

atkPower=475+(oPlayer1.hitCombo*5)
damageType="ELEMENTAL"
weaponTag=151
global.recAtkNum+=1
bCanPierce=1
stunTime=1
decayTime=9
lingerFrame=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if lingerFrame=0
  {
    image_alpha-=0.06
    image_angle=direction
    speed=10.5

    if isCollisionLeft(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionRight(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionBottom(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionTop(1) {lingerFrame=1; speed=0; visible=0}

    decayTime-=1
    if decayTime<=0 {instance_destroy()}
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}

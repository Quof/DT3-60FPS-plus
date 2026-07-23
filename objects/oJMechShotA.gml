#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

atkPower=1000+(oPlayer1.hitCombo*10)
damageType="SHOT"
weaponTag=150
global.recAtkNum+=1
stunTime=1
decayTime=35
lingerFrame=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sSamusSMissileHit; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
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
    image_angle=direction
    speed=13

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

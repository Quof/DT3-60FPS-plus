#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-4,3,4)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
effectDelay=0
weight=50
bBlownUp=false
grav=1.25
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  if direction>270
  {
    if direction>290 {direction-=2}
  }
  else
  {
    if direction<250 {direction+=2}
  }
  y+=grav
  image_angle=direction
  if isCollisionTop(1) {bBlownUp=true}
  if isCollisionBottom(1) {bBlownUp=true}
  if isCollisionLeft(1) {bBlownUp=true}
  if isCollisionRight(1) {bBlownUp=true}
  if bBlownUp=true
  {
    newAttack=instance_create(x,y,oDamageExpDashHit)
    newAttack.atkPower=atkPower; newAttack.sprite_index=sEfFirePillar
    newAttack.image_speed=0.75; newAttack.decayTime=-100
    playSound(global.snd_BombExplode,0,0.9,1)
    instance_destroy()
  }
  moveTo(xVel,yVel)

  if y>room_height+32
    instance_destroy()
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)

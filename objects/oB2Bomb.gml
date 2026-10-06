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
bombTick=0 //60fps change (added): this bomb's own 30fps tick count, so it turns once per tick (see the Step event)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=bulletSpeed
  bombTick+=gDeltaTime //60fps change (added): turn 2 degrees once per 30fps tick (it turned 2 degrees every frame, 2x/4x as fast at 60/120fps), as in oLinkArrow
  if frac(bombTick-gDeltaTime)=0 { //60fps change (added)
  if _direction>270
  {
    if _direction>290 {_direction-=2}
  }
  else
  {
    if _direction<250 {_direction+=2}
  }
  } //60fps change (added)

  y+=grav*gDeltaTime
  image_angle=_direction

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
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if y>room_height+32
    instance_destroy()
}
else {_speed=0}
correctSpeedDirection(self)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)

#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
***** Requires *****
** bulletSpeed: initial speed when launched (and used for current speed during seeking behavior)
** minSpd: minimum speed when turning
** maxSpd: maximum speed when seeking
** turnSpd: degrees to rotate each frame
** accel: acceleration and deceleration when turning/seeking
** seekThres: angle difference from self to target before acceleration kicks in
** targetTime: time till seeking behavior starts
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
hitWall=0
atkProg=0
diff=100
decay=210
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  image_angle=direction
  atkProg+=1
  if atkProg>=targetTime
  {
    if oGame.time mod 3=0
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    diff=angle_difference(image_angle,player_sprite_center())
    if diff<seekThres and diff>-seekThres
    {
      if bulletSpeed<maxSpd {bulletSpeed+=accel}
    }
    else
    {
      if bulletSpeed>minSpd {bulletSpeed-=accel}
    }

    turn_toward_direction(player_sprite_center(),turnSpd)
  }

  decay-=1
  if decay<=0 {hitWall=2}
  if isCollisionTop(1) {hitWall=1}
  if isCollisionBottom(1) {hitWall=1}
  if isCollisionLeft(1) {hitWall=1}
  if isCollisionRight(1) {hitWall=1}
  if hitWall=1
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusMissileHit; tEffect.image_speed=0.66
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  else if hitWall=2
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.66
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true and oPlayer1.dashInvulnerabilityTime=0 {hitWall=2}
event_inherited()
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="EXPLOSION"
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_destroy()
}

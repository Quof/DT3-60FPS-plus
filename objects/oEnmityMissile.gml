#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
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
bulletSpeed=2
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
    if room=rBubbleTowerA7
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.25; tEffect.speed=1; tEffect.direction=direction-180
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else
    {
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.5; tEffect.speed=1; tEffect.direction=direction-180
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }

    diff=angle_difference(image_angle,player_sprite_center())
    if diff<18 and diff>-18
    {
      if bulletSpeed<7 {bulletSpeed+=0.25}
    }
    else
    {
      if bulletSpeed>2 {bulletSpeed-=0.25}
    }

    turn_toward_direction(player_sprite_center(),3)
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
else
  speed=0
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

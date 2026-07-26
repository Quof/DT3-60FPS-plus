#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
explodePointX=oPlayer1.x
explodePointY=returnPlayerYCenter()
pointFrm=0
size=2
speed=0
direction=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=bulletSpeed
  if sprite_index=sSE_DarkBall {image_angle-=20*gDeltaTime}
  else {image_angle=_direction}

  if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed
  {
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower; newAttack.decayTime=-100
    newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
    newAttack.image_xscale=1.25; newAttack.image_yscale=1.25
    if sprite_index=sSE_DarkBall {newAttack.image_blend=c_purple}
    instance_destroy()
  }
  speed=0
  x += cos(degtorad(_direction)) * _speed * gDeltaTime
  y -= sin(degtorad(_direction)) * _speed * gDeltaTime
}
else {speed=0; _speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
pointFrm+=0.2
draw_sprite_ext(sChaoTarget,pointFrm,explodePointX,explodePointY,1.25,1.25,0,c_white,0.75)
event_inherited()

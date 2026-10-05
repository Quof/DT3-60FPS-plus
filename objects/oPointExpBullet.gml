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
_speed=0
_direction=0
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

  if !variable_local_exists("peTk") {peTk=0} //60fps change (added): counts this bullet's 30fps ticks
  //if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed
  if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed and frac(peTk)=0 //60fps change: checked once per 30fps tick (before that tick's move) like at 30fps
  {
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower; newAttack.decayTime=-100
    newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
    newAttack.image_xscale=1.25; newAttack.image_yscale=1.25
    if sprite_index=sSE_DarkBall {newAttack.image_blend=c_purple}
    instance_destroy()
  }
  //_speed=0
  //60fps change: removed the "_speed=0" above; it ran every step right before correctSpeedDirection, so this bullet never moved at all
  peTk+=gDeltaTime //60fps change (added)
}
else {_speed=0; _speed=0}
correctSpeedDirection(self)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//pointFrm+=0.2
pointFrm+=0.2*gDeltaTime //60fps change: Draw runs every frame, so the target marker animated 2x/4x as fast
draw_sprite_ext(sChaoTarget,pointFrm,explodePointX,explodePointY,1.25,1.25,0,c_white,0.75)
event_inherited()

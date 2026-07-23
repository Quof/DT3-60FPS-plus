#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-4,-4,4,4)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
hitWall=0
atkProg=0
turnSpd=1.5
decay=150
bTouchSpikeCeiling=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if collision_circle(x,y,4,oCh19CeilingTrap,1,1) {bTouchSpikeCeiling=1}
  else {bTouchSpikeCeiling=0}

  if atkProg=0
  {
    if !instance_exists(myOwner) {instance_destroy()}
  }
  else if atkProg=1
  {
    direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    atkProg+=1
  }
  else if atkProg=2
  {
    speed=8
    image_angle+=5
    turn_toward_direction(player_sprite_center(),turnSpd)
  }

  decay-=1
  if decay<=0 {instance_destroy()}
}
else {speed=0}
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
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTouchSpikeCeiling=0
{
  depth=25
  draw_set_blend_mode(bm_add)
  event_inherited()
  draw_set_blend_mode(bm_normal)
}
else
{
  depth=8
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_black,0.15)
}

#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_index=random(image_number)
image_speed=0.33
image_xscale=1.25; image_yscale=1.25
image_alpha=0.25

//Enemy base statistics
atkPower=12
bCanTakeDamage=0
bShowHealthBar=0
damageType="ELEMENTAL"

fireProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if fireProg=0
  {
    image_alpha+=0.01
    if image_alpha=0.75 {fireProg=1}
  }

  if image_alpha>=0.5 {bCanDealDamage=1}
  else {bCanDealDamage=0}
}
#define Collision_oIdentifier
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true and global.gamePaused=false
{
  with oPlayer1
    hitPlayer(other.id)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

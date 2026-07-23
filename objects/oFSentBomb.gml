#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
bDestroy=0
weight=50
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=grav
  if isCollisionTop(1)
    bDestroy=1
  if isCollisionBottom(1)
    bDestroy=1
  if isCollisionLeft(1)
    bDestroy=1
  if isCollisionRight(1)
    bDestroy=1
  moveTo(xVel,yVel)

  if bDestroy=1
  {
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion; newAttack.decayTime=-100
    instance_destroy()
  }

  if y>room_height+32
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.9)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y,10,c_orange,c_black,false)
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

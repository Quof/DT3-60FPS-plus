#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
animSpeed=0.25
arrowY=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_index+=animSpeed
  arrowY+=0.4
}
#define Other_7
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
if instance_exists(ownerID)
{
  draw_set_blend_mode(bm_add)
  draw_sprite_ext(sprite_index,image_index,ownerID.x+xOffset,ownerID.y+yOffset,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_set_blend_mode(bm_normal)
  draw_sprite(sPauseM_AtkTypes,atkType,ownerID.x+xOffset-12,ownerID.y+yOffset-8)
  if atkUp=1
    draw_sprite_ext(sPauseM_Cursor,0,ownerID.x+xOffset+12,ownerID.y+yOffset+2-arrowY,1,1,90,image_blend,image_alpha)
  else
    draw_sprite_ext(sPauseM_AbilArrow,0,ownerID.x+xOffset+12,ownerID.y+yOffset-2+arrowY,1,1,270,image_blend,image_alpha)
}

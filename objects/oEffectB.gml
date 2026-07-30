#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if AccelX!=0
  speed+=AccelX*gDeltaTime
if AccelY!=0
  speed+=AccelY*gDeltaTime
image_angle+=rotation*gDeltaTime

if type=2 //Time
{
  decay-=1*gDeltaTime
  if decay=0 {instance_destroy()}
}
else if type=3 //Fade away
{
  image_alpha-=fadeSpd*gDeltaTime
  if image_alpha<=0 {instance_destroy()}
}
else if type=4 //Speed down
{
  if speed<0.25 {instance_destroy()}
}
else if type=5 //Size down
{
  image_xscale-=fadeSpd*gDeltaTime
  image_yscale-=fadeSpd*gDeltaTime
  if image_xscale<=0 {instance_destroy()}
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if newBlend!=-1
{
  draw_set_blend_mode(bm_add)
  if followID!=-1
  {
    if instance_exists(followID)
      draw_sprite_ext(sprite_index,-1,followID.x+xFollow,followID.y+yFollow,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  else
  {
    if instance_exists(followID)
      draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  draw_set_blend_mode(bm_normal)
}
else
{
  if followID!=-1
  {
    if instance_exists(followID)
      draw_sprite_ext(sprite_index,-1,followID.x+xFollow,followID.y+yFollow,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  else
    draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

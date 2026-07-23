#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.3
decayTime=0
emoteScale=0.1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if emoteScale<1 {emoteScale+=0.1}
else
{
  decayTime+=1
  if decayTime>=50
  {
    image_alpha-=0.1
    if image_alpha<=0 {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(followID)
{
  draw_sprite_ext(sprite_index,image_index,followID.x+x,followID.y+y,emoteScale,emoteScale,image_angle,image_blend,image_alpha)
}
else {instance_destroy()}

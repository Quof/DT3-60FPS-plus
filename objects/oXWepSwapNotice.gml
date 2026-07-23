#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
lifeTime=40
wepType=global.MMactiveAtk+7
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lifeTime-=1
if lifeTime<=20
{
  image_alpha-=0.05
  if lifeTime=0
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_sprite_ext(sPauseM_AtkTypes,wepType,oPlayer1.x-8,oPlayer1.y-69,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

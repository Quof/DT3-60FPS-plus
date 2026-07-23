#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
lightFlash=irandom(40)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lightFlash+=1
if lightFlash=80
{
  image_blend=c_green
}
else if lightFlash>=83
{
  image_blend=c_white
  lightFlash=irandom(40)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_angle=0
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x+(i*16),y,1,1,image_angle,image_blend,image_alpha)
  }
}
else if image_angle=90
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x,y-(i*16),1,1,image_angle,image_blend,image_alpha)
  }
}
else if image_angle=180
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x-(i*16),y,1,1,image_angle,image_blend,image_alpha)
  }
}
else if image_angle=270
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x,y+(i*16),1,1,image_angle,image_blend,image_alpha)
  }
}
